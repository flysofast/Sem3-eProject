using AirlineReservation.Models;
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
                    var result = path.Select(p => new
                    {
                        p.CityID,
                        p.CityName
                    }).ToList();

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
        /// Get flight lists of the route
        /// </summary>
        /// <param name="vertices"></param>
        /// <returns>List of flight lists</returns>
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

                    var result = dataResult.Select(q => q.Select(p => new
                    {
                        Departure = p.DepartureTime.ToShortTimeString() + " (" + p.Route.OriginalCity.CityName + ")",
                        Arrival = (p.DepartureTime.Add(TimeSpan.FromHours(p.Duration))).ToShortTimeString() + " (" + p.Route.DestinationCity.CityName + ")",
                        Duration = TimeSpan.FromHours(p.Duration).ToString("h\\h\\ mm\\m\\ "),
                        Price = p.CurrentPrice + " VND"
                    }));

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
                var result = db.Cities.Where(p => exclusion == null || !p.CityID.Equals(exclusion)).ToList();
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
                    return Json(city.CityID, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var nearestRoute = city.RoutesAsOriginal.OrderBy(p => p.Distance).First();
                    return Json(nearestRoute.DestinationCityID, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

    }
}
