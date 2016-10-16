﻿using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class HomeController : Controller
    {
        private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        public ActionResult Index()
        {
            return View();
        }

        #region Step 1

        /// <summary>
        /// Get shortes possible path for the route between 2 cities
        /// </summary>
        /// <param name="OriginalCityID"></param>
        /// <param name="DestinationCityID"></param>
        /// <returns></returns>
        public JsonResult GetPossibleFlightScheduleAPI(string OriginalCityID, string DestinationCityID)
        {
            try
            {
                Dijkstra d = new Dijkstra(OriginalCityID, DestinationCityID);
                var path = d.GetShortestPath();
                if (path.Count > 0)
                {
                    var result = path.Select(p => new
                    {
                        p.CityID,
                        p.CityName
                    }).ToList();

                    FlightScheduleUtilities fu = new FlightScheduleUtilities();
                    var a = fu.FindFlightsOfRoute(path[0].CityID, path[1].CityID, 3, "First class", new DateTime(2016, 10, 20));
                    var s = "";
                    foreach (var item in a)
                    {
                        s += string.Format("NO: {0} ORI: {1} DES: {2} DEP: {3} AVAIL: {4}\n", item.FlightNo, item.Route.OriginalCityID, item.Route.DestinationCityID, item.DepartureTime.ToString("d/MM/yyyy H:mm"), db.Seats.Count() - item.TakenSeats.Count());
                        Console.WriteLine(s);
                    }

                    return Json(result, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(0, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        /// <summary>
        /// Get a list of cities
        /// </summary>
        /// <param name="exclusion">except for this city</param>
        /// <returns></returns>
        public JsonResult GetCityListAPI(string exclusion = null)
        {
            try
            {
                var result = db.Cities.Where(p => string.IsNullOrEmpty(exclusion) || !p.CityID.Equals(exclusion)).Select(p => new
                {
                    p.CityID,
                    p.CityName
                }).ToList();
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        /// <summary>
        /// Check if a city is available for departure or arrival
        /// </summary>
        /// <param name="cityID"></param>
        /// <returns>The nearest available city's ID or the same city's ID if it's available</returns>
        public JsonResult GetNearestAvailableAPI(string cityID)
        {
            try
            {
                var city = db.Cities.Single(p => p.CityID.Equals(cityID));
                if (city.InService)
                {
                    var nearestCity = db.Cities.Where(p => p.CityID == cityID).Select(p => new
                    {
                        CityID = p.CityID,
                        CityName = p.CityName,
                        Distance = 0
                    }).First();
                    return Json(nearestCity, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var nearestCity = city.RoutesAsOriginal.OrderBy(p => p.Distance).Select(p => new
                    {
                        CityID = p.DestinationCityID,
                        CityName = p.DestinationCity.CityName,
                        Distance = p.Distance
                    }).First();

                    return Json(nearestCity, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        #endregion Step 1

        #region Step 2

        /// <summary>
        /// Get list of classes
        /// </summary>
        /// <returns></returns>
        public JsonResult GetClassListAPI()
        {
            try
            {
                var result = db.Seats.Select(p => new
                {
                    p.Class
                }).Distinct().ToList();

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        #endregion Step 2

        #region Step 3

        /// <summary>
        /// Gets flight lists of the flight schedule
        /// </summary>
        /// <param name="route"></param>
        /// <param name="classes"></param>
        /// <param name="dates"></param>
        /// <param name="passengers"></param>
        /// <param name="isReturning"></param>
        /// <returns>List of flight lists.
        /// If one-way flight, returns a list with 1 object (a list of departure flights), otherwise returns 2 lists (departure and returning flights)
        /// If the route is not found, returns 0</returns>
        public JsonResult GetFlightsAPI(List<string> route, List<string> classes, List<DateTime> dates, List<int> passengers, bool isReturning)
        {
            try
            {
                if (route.Count > 0)
                {
                    // Posible Schedules: [ Departure flight lists:[ Node 1 flight list: [AR001, AR002,...], Node 2 flight list: [AR034, AR374...], Returning flight lists: [ [....]   ]  ]   ]
                    List<List<List<Flight>>> result = new List<List<List<Flight>>>();

                    //Number of requested seats
                    int numberOfRequestedSeats = 0;

                    //Number of seats on the planes
                    int numberOfSeats = db.Seats.Count(p => true);

                    foreach (var item in passengers)
                    {
                        numberOfRequestedSeats += item;
                    }

                    #region Departure flight search

                    //Departure date
                    var requestedDate = dates[0].Date;

                    // Node list
                    //var cityList = new List<City>();

                    //for (int i = 0; i < route.Count; i++)
                    //{
                    //    var cityID = route[i];
                    //    var city = db.Cities.Single(p => p.CityID.Equals(cityID));
                    //    cityList.Add(city);
                    //}

                    //db.TakenSeats.Where(tk => tk.FlightNo.Equals(p.FlightNo) && tk.Seat.Class.Equals(classes[0])).Select(tk => tk.Seat)
                    FlightScheduleUtilities ru = new FlightScheduleUtilities();

                    var searchResult = ru.FindFlights(route, numberOfRequestedSeats, classes[0], dates[0]);

                    var departureFlightLists = searchResult.Select(node =>

                    //node.Where(flight =>

                    //    //Check departure date
                    //    DateTime.Compare(flight.DepartureTime.Date, requestedDate) == 0 &&

                    //    //Check if there are enough available seats of the requested class

                    //    //All the seats of the class
                    //    db.Seats.Where(seat => seat.Class.Equals(classes[0]))
                    //    //Except for those seats that have been taken of that flight
                    //    .Except(db.TakenSeats.Where(takenSeat => takenSeat.FlightNo.Equals(flight.FlightNo) && takenSeat.Seat.Class.Equals(classes[0]))
                    //        .Select(tk => tk.Seat))

                    //    .Count() >= numberOfRequestedSeats

                    //)
                    node.Select(flight => new
                    {
                        Departure = flight.DepartureTime.ToShortTimeString() + " (" + flight.Route.OriginalCity.CityName + ")",
                        Arrival = (flight.DepartureTime.Add(TimeSpan.FromHours(flight.Duration))).ToShortTimeString() + " (" + flight.Route.DestinationCity.CityName + ")",
                        Duration = TimeSpan.FromHours(flight.Duration).ToString("h\\h\\ mm\\m\\ "),
                        Price = flight.CurrentPrice + " VND"
                    }));

                    #endregion Departure flight search

                    return Json(result, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(0, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        #endregion Step 3
    }
}