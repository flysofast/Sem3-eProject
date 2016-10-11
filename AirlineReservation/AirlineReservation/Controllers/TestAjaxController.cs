﻿using AirlineReservation.Models;
using DemoDijkstra;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class TestAjaxController : Controller
    {
        AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Get shortes possible path for the route between 2 cities
        /// </summary>
        /// <param name="OriginalCityID"></param>
        /// <param name="DestinationCityID"></param>
        /// <returns></returns>
        public JsonResult GetPossibleRouteAPI(string OriginalCityID, string DestinationCityID)
        {
            try
            {
                Dijkstra d = new Dijkstra(OriginalCityID, DestinationCityID);
                var path = d.GetShortestPath();
                if (path.Count > 0)
                {
                    var result = new List<CityJson>();
                    for (int i = 0; i < path.Count; i++)
                    {
                        var item = new CityJson();
                        item.CityID = path[i].CityID;
                        item.CityName = path[i].CityName;
                        result.Add(item);
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

        public JsonResult GetFlightsAPI(List<string> vertices)
        {
            try
            {
                if (vertices.Count > 0)
                {
                    var cityList = new List<City>();

                    for (int i = 0; i < vertices.Count; i++)
                    {
                        var cityID = vertices[i];
                        var city = db.Cities.Single(p => p.CityID.Equals(cityID));
                        cityList.Add(city);
                    }
                    RouteUtilities ru = new RouteUtilities();

                    var dataResult = ru.FindFlight(cityList);

                    var result = new List<List<>>();

                    foreach (var list in dataResult)
                    {
                        var flightList = list.Select(p => new
                        {
                            Departure = p.DepartureTime.ToShortTimeString() + " (" + p.Route.OriginalCity.CityName + ")",
                            Arrival = (p.DepartureTime.Add(TimeSpan.FromHours(p.Duration))).ToShortTimeString() + " (" + p.Route.DestinationCity.CityName + ")",
                            Duration = p.Duration + " hours",
                            Price = p.CurrentPrice + " VND"
                        }).ToList();

                        result.Add(flightList);
                    }

                    var a = new List<string>();
                    a.Add("dasd");
                    a.Add("dasd");
                    var b = new List<string>();
                    a.Add("d1asd");
                    a.Add("dae23sd");

                    result.Add(a);
                    result.Add(b);

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

        public class CityJson
        {
            [Display(Name = "CityID")]
            public string CityID { set; get; }

            [Display(Name = "CityName")]
            public string CityName { set; get; }


        }

        public class FlightJson
        {
            [Display(Name = "Departure")]
            public string Departure { set; get; }

            [Display(Name = "Arrival")]
            public string Arrival { set; get; }
            [Display(Name = "Duration")]
            public string Duration { set; get; }
            [Display(Name = "Price")]
            public string Price { set; get; }


        }


    }
}
