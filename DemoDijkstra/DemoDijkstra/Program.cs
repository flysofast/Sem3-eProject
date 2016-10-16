using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoDijkstra
{
    internal class Program
    {
        private static AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        private static void Main(string[] args)
        {
            //GenerateFlights();

            //GenerateSeats();

            var list = FindFlightsOfRoute("HNN", "HUI", 11, "First class", new DateTime(2016, 10, 20));
            foreach (var item in list)
            {
                var s = string.Format("NO: {0} ORI: {1} DES: {2} DEP: {3} AVAIL: {4}\n", item.FlightNo, item.Route.OriginalCityID, item.Route.DestinationCityID, item.DepartureTime.ToString("d/MM/yyyy H:mm"), db.Seats.Count() - item.TakenSeats.Count());
                Console.WriteLine(s);
            }

            Console.WriteLine("DONE");
            Console.ReadKey();

            //GenerateFlights();
        }

        private static void ShowShortestPath()
        {
            try
            {
                Dijkstra d = new Dijkstra("HNN", "NYK");

                //Get sequence of flights for a route
                //d.GetShortestPath();

                RouteUtilities ru = new RouteUtilities();

                //Find all possible flight for a route
                var flightLists = ru.FindFlight(d.GetShortestPath());

                foreach (var flights in flightLists)
                {
                    if (flights != null)
                    {
                        Console.WriteLine("-----------------------------");
                        foreach (var flight in flights)
                        {
                            if (flight == null) continue;
                            Console.WriteLine(flight.Route.OriginalCity.CityID + " ---> " + flight.Route.DestinationCityID + " " + flight.DepartureTime.ToString());
                        }
                    }
                }
            }
            catch (KeyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        static public List<Flight> FindFlightsOfRoute(string originalCityID, string destinationCityID, int passengers, string className, DateTime date)
        {
            var route = db.Routes.FirstOrDefault(p => p.InService && p.OriginalCityID == originalCityID && p.DestinationCityID == destinationCityID);

            if (route == null)
            {
                return null;
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
                db.Seats.Where(seat => seat.Class.Equals(className))
                //Except for those seats that have been taken of that flight
                .Except(db.TakenSeats.Where(takenSeat => takenSeat.FlightNo.Equals(flight.FlightNo) && takenSeat.Seat.Class.Equals(className))
                    .Select(tk => tk.Seat))

                .Count() >= passengers
            ).ToList();
        }

        private static void GenerateSeats()
        {
            try
            {
                Console.WriteLine("STARTING TO GENERATE SEAT INFO");
                for (int i = 1; i <= 10; i++)
                {
                    for (int j = 65; j <= 70; j++)
                    {
                        char character = (char)j;
                        string letter = character.ToString();
                        string seatID = i.ToString() + letter;

                        Seat seat = new Seat();
                        seat.SeatID = seatID;
                        switch (i)
                        {
                            case 1:
                            case 2:
                                seat.Class = "First class";
                                break;

                            case 3:
                            case 4:
                                seat.Class = "Business class";
                                break;

                            case 5:
                            case 6:
                                seat.Class = "Club class";
                                break;

                            case 7:
                            case 8:
                                seat.Class = "Non-smoking class";
                                break;

                            case 9:
                            case 10:
                                seat.Class = "Smoking class";
                                break;

                            default:
                                break;
                        }

                        db.Seats.Add(seat);
                    }
                }

                db.SaveChanges();

                Console.WriteLine("DONE");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private static void GenerateFlights()
        {
            int numberOfFlightPerday = 20;
            int numberOfDays = 20;
            int currentFlightID = 1;
            DateTime startingDate = DateTime.Now.Date;
            Random r = new Random();
            var routeList = db.Routes.Where(p => p.InService).ToList();
            Console.WriteLine("Adding new flights");
            for (int day = 0; day < numberOfDays; day++)
            {
                for (int i = 0; i < numberOfFlightPerday; i++)
                {
                    Flight flight = new Flight();
                    flight.FlightNo = "AR" + currentFlightID.ToString("D4");
                    currentFlightID++;
                    //flight.d
                    DateTime departureDate = startingDate.AddDays(day);
                    TimeSpan time = new TimeSpan(r.Next(0, 24), r.Next(0, 12) * 5, 0);
                    departureDate = departureDate.Add(time);

                    flight.DepartureTime = departureDate;
                    var route = routeList[r.Next(routeList.Count)];
                    flight.Route = route;
                    flight.CurrentPrice = route.Distance * 1500;
                    flight.Duration = (float)route.Distance / 900;

                    db.Flights.Add(flight);
                    if (db.SaveChanges() <= 0)
                    {
                        i--;
                        Console.WriteLine("Cannot create new route number: " + flight.FlightNo);
                    }
                }
            }

            Console.WriteLine("DONE");
        }
    }
}