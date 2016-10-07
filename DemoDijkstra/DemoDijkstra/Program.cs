﻿using System;
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
            //try
            //{
            //    Dijkstra d = new Dijkstra("HNN", "NYK");
            //    d.GetShortestPath();
            //}
            //catch (KeyNotFoundException ex)
            //{
            //    Console.WriteLine(ex.Message);
            //}
            //Console.ReadKey();

            GenerateFlights();


        }

        static void GenerateFlights()
        {
            int numberOfFlightPerday = 20;
            int numberOfDays = 20;
            int currentFlightID = 1;
            DateTime startingDate = DateTime.Now.Date;
            Random r = new Random();
            var routeList = db.Routes.Where(p => p.InService).ToList();
            Console.WriteLine("DANG THEM RECORD");
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
                        Console.WriteLine("CO LOI 1 record " + flight.FlightNo);
                    }
                }

            }

            Console.WriteLine("XONG");
        }
    }
}
