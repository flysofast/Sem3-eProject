﻿using AirlineReservation.Models;
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
    /// <param name="date"></param>
    /// <returns>Empty list if no flight found, else returns the list</returns>
    public List<Flight> FindFlightsOfRoute(string originalCityID, string destinationCityID, int passengers, string className, DateTime date)
    {
        var route = db.Routes.FirstOrDefault(p => p.InService && p.OriginalCityID == originalCityID && p.DestinationCityID == destinationCityID);

        if (route == null)
        {
            return new List<Flight>(); ;
        }

        return db.Flights.Where(flight =>

            //Flights of the route
            flight.RouteID == route.RouteID &&

            //Check departure date
            //DateTime.Compare(flight.DepartureTime.Date, date) == 0 &&
            //flight.DepartureTime == date &&
            EntityFunctions.TruncateTime(flight.DepartureTime) == EntityFunctions.TruncateTime(date) &&

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
    /// <param name="date"></param>
    /// <returns></returns>
    public List<List<Flight>> FindFlights(List<string> cityIDSequence, int passengers, string className, DateTime date)
    {
        List<List<Flight>> result = new List<List<Flight>>();
        for (int i = 0; i < cityIDSequence.Count - 1; i++)
        {
            result.Add(FindFlightsOfRoute(cityIDSequence[i], cityIDSequence[i + 1], passengers, className, date));
        }

        return result;
    }

    private Ticket CreateTicket(string userID, string[] classes, Flight[] flights, bool[] isReturning, int[] sequenceNumber, int[] passengers, decimal totalPrice)
    {
        using (var transaction = new TransactionScope())
        {
            try
            {
                var ticket = new Ticket();
                ticket.UserID = userID;
                ticket.Status = 1;
                ticket.Price = totalPrice;
                ticket.CreatedDate = DateTime.Now;
                ticket.NumberOfAdults = passengers[0];
                ticket.NumberOfChildren = passengers[1];
                ticket.NumberOfSeniorCitizens = passengers[2];
                db.Tickets.Add(ticket);
                db.SaveChanges();

                for (int i = 0; i < flights.Length; i++)
                {
                    var ticketDetails = new Ticket_Flight();
                    ticketDetails.TicketNo = ticket.TicketNo;
                    ticketDetails.FlightNo = flights[i].FlightNo;
                    ticketDetails.SequenceNo = sequenceNumber[i];
                    ticketDetails.IsReturning = isReturning[i];
                    db.Ticket_Flight.Add(ticketDetails);
                    db.SaveChanges();

                    //Assign available seats for the passengers, prefer to put them next to each other
                    string seatClass;
                    if (isReturning[i])
                    {
                        seatClass = classes[0];
                    }
                    else
                    {
                        seatClass = classes[1];
                    }

                    int totalPassengers = passengers[0] + passengers[1] + passengers[2];

                    //List of vacant seats of the class
                    var availableSeats = db.Seats.Where(p => p.Class.Equals(seatClass) &&
                    p.TakenSeats.Count(q => q.FlightNo.Equals(flights[i].FlightNo)) == 0).Select(p => p.SeatID).ToList();

                    //Double check the database
                    if (availableSeats.Count < totalPassengers)
                    {
                        throw new ArgumentException();
                    }

                    for (int j = 0; j < totalPassengers; j++)
                    {
                        var takenSeat = new TakenSeat();
                        takenSeat.FlightNo = flights[i].FlightNo;

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

                transaction.Complete();
                return ticket;
            }
            catch (Exception ex)
            {
                transaction.Dispose();
                return null;
            }
        }
    }

    public class TicketStatus
    {
        public int Blocked = 0;
        public int Confirmed = 1;
        public int Cancelled = 2;
    }
}