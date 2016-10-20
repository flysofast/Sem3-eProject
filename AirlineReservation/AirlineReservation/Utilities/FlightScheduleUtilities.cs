using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

public class FlightScheduleUtilities
{
    private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
    private Random random = new Random();

    /// <summary>
    /// Find list of flights that sastisfy the conditions
    /// </summary>
    /// <param name="originalCityID"></param>
    /// <param name="destinationCityID"></param>
    /// <param name="passengers"></param>
    /// <param name="className"></param>
    /// <param name="fromDate"></param>
    /// <param name="toDate">The end of date range</param>
    /// <returns>Empty list if no flight found, else returns the list</returns>
    public List<Flight> FindFlightsOfRoute(string originalCityID, string destinationCityID, int passengers, string className, DateTime fromDate, DateTime toDate)
    {
        var route = db.Routes.FirstOrDefault(p => p.InService && p.OriginalCityID == originalCityID && p.DestinationCityID == destinationCityID);

        if (route == null)
        {
            return new List<Flight>(); ;
        }

        //If date range is an invalid range
        if (toDate < fromDate)
        {
            toDate = fromDate;
        }

        return db.Flights.Where(flight =>

            //Flights of the route
            flight.RouteID == route.RouteID &&

            //Check departure date
            //DateTime.Compare(flight.DepartureTime.Date, date) == 0 &&
            //flight.DepartureTime == date &&
            EntityFunctions.TruncateTime(flight.DepartureTime) >= EntityFunctions.TruncateTime(fromDate) &&
            EntityFunctions.TruncateTime(flight.DepartureTime) <= EntityFunctions.TruncateTime(toDate) &&
            //Check if there are enough available seats of the requested class

            //All the seats of the class
            db.Seats.Where(seat => className.Equals("Any") || seat.Class.Equals(className))
            //Except for those seats that have been taken of that flight
            .Except(db.TakenSeats.Where(takenSeat => takenSeat.FlightNo.Equals(flight.FlightNo) && takenSeat.Seat.Class.Equals(className))
                .Select(tk => tk.Seat))

            .Count() >= passengers
        ).ToList();
    }

    /// <summary>
    /// Find the flights for a path of cities
    /// </summary>
    /// <param name="cityIDSequence"></param>
    /// <param name="passengers"></param>
    /// <param name="className"></param>
    /// <param name="fromDate"></param>
    /// <returns></returns>
    public List<List<Flight>> FindFlights(List<string> cityIDSequence, int passengers, string className, DateTime fromDate, DateTime toDate)
    {
        List<List<Flight>> result = new List<List<Flight>>();
        for (int i = 0; i < cityIDSequence.Count - 1; i++)
        {
            result.Add(FindFlightsOfRoute(cityIDSequence[i], cityIDSequence[i + 1], passengers, className, fromDate, toDate));
        }

        return result;
    }

    /// <summary>
    /// Block or Buy a ticket
    /// </summary>
    /// <param name="userID"></param>
    /// <param name="flights"></param>
    /// <param name="passengers"></param>
    /// <param name="totalPrice"></param>
    /// <param name="requestType">Block request or Buy request. More on TicketStatus class.</param>
    /// <returns>If the process succeeded, returns the ticket, otherwise returns null</returns>
    public Ticket CreateTicket(string userID, List<BookedFlightInfo> flights, int[] passengers, decimal totalPrice, int requestType)
    {
        using (var transaction = new TransactionScope())
        {
            try
            {
                var ticket = new Ticket();
                ticket.UserID = userID;
                ticket.Status = 0;
                ticket.Price = totalPrice;
                ticket.CreatedDate = DateTime.Now;
                ticket.NumberOfAdults = passengers[0];
                ticket.NumberOfChildren = passengers[1];
                ticket.NumberOfSeniorCitizens = passengers[2];
                db.Tickets.Add(ticket);
                db.SaveChanges();

                for (int i = 0; i < flights.Count; i++)
                {
                    var flight = flights[i];

                    //Check if the departure date is a date in the past
                    var theFlight = db.Flights.Single(p => p.FlightNo.Equals(flight.FlightNumber));
                    if (theFlight.DepartureTime < DateTime.Now)
                    {
                        throw new ArgumentException("The departure date is not valid");
                    }

                    if (requestType == TicketStatus.Blocked)
                    {
                        //Check if the date is valid for blocking
                        var dateDiff = theFlight.DepartureTime.Subtract(DateTime.Now).TotalDays;
                        if (dateDiff < 14 || dateDiff > 365)
                        {
                            throw new ArgumentException(string.Format("The flight {0} ({1} to {2}) departure date must be more than 14 days from today, but no more than 365 days", flight.FlightNumber, theFlight.Route.OriginalCity.CityName, theFlight.Route.DestinationCity.CityName));
                        }
                    }

                    var ticketDetails = new Ticket_Flight();
                    ticketDetails.TicketNo = ticket.TicketNo;
                    ticketDetails.FlightNo = flight.FlightNumber;
                    ticketDetails.SequenceNo = flight.SequenceNumber;
                    ticketDetails.IsReturning = flight.IsReturning;
                    db.Ticket_Flight.Add(ticketDetails);
                    db.SaveChanges();

                    //Assign available seats for the passengers, prefer to put them next to each other
                    int totalPassengers = passengers[0] + passengers[1] + passengers[2];

                    //List of vacant seats of the class
                    var availableSeats = db.Seats.Where(p => (flight.Class.Equals(ClassNames.Any) || p.Class.Equals(flight.Class)) &&
                    p.TakenSeats.Count(q => q.FlightNo.Equals(flight.FlightNumber)) == 0).Select(p => p.SeatID).ToList();

                    //Double check the database
                    if (availableSeats.Count < totalPassengers)
                    {
                        throw new ArgumentException("There are not enough available seats for this specification");
                    }

                    for (int j = 0; j < totalPassengers; j++)
                    {
                        var takenSeat = new TakenSeat();
                        takenSeat.FlightNo = flight.FlightNumber;

                        //Always pick the first available seat to gain more chance of boarding together
                        var selectedSeat = availableSeats[0];

                        takenSeat.TicketNo = ticket.TicketNo;
                        takenSeat.SeatID = selectedSeat;

                        //Remove the selected seat from the available list
                        availableSeats.Remove(selectedSeat);

                        db.TakenSeats.Add(takenSeat);
                    }
                    db.SaveChanges();
                }

                //Set ticket's status
                string generatedCode = requestType.ToString("D2") + ticket.TicketNo.ToString();
                switch (requestType)
                {
                    case TicketStatus.Confirmed:
                        ChargeUser(userID, totalPrice);
                        ticket.ConfirmationNo = generatedCode;
                        ticket.Status = TicketStatus.Confirmed;
                        break;

                    case TicketStatus.Blocked:
                        //Check if the date is valid for blocking

                        ticket.BlockNo = generatedCode;
                        ticket.Status = TicketStatus.Blocked;
                        break;

                    default:
                        throw new ArgumentException("The requested command is not valid");
                }
                db.SaveChanges();

                transaction.Complete();
                return ticket;
            }
            catch (Exception ex)
            {
                transaction.Dispose();
                throw ex;
                //return null;
            }
        }
    }

    /// <summary>
    /// Charge user
    /// </summary>
    /// <param name="UserID"></param>
    /// <param name="amount"></param>
    private void ChargeUser(string UserID, decimal amount)
    {
        var user = db.Users.Single(p => p.UserID.Equals(UserID));

        //Validate
        if (!ValidateCreditCardNumber(user.CreditcardNumber))
        {
            throw new ArgumentException("The credit card information is not valid");
        }

        Console.WriteLine(UserID + " has just been charge for " + amount);
    }

    /// <summary>
    /// Validate the credit card info
    /// </summary>
    /// <param name="creditCard"></param>
    /// <returns></returns>
    private bool ValidateCreditCardNumber(string creditCard)
    {
        return !string.IsNullOrEmpty(creditCard);
    }
}