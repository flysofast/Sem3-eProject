using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoDijkstra
{
    class Program
    {
        static AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        static void Main(string[] args)
        {
            //GenerateFlights();
            try
            {
                Dijkstra d = new Dijkstra("HNN", "NYK");

                //Get sequence of flights for a route
                //d.GetShortestPath();

                RouteUtilities ru = new RouteUtilities();

                //Find all possible flight for a route
                var flightLists=ru.FindFlight(d.GetShortestPath());

                foreach(var flights in flightLists)
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
            Console.ReadKey();

            //GenerateFlights();


        }

        static void GenerateFlights()
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
