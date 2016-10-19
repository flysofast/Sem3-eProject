using AirlineReservation.Models;
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
                    var classes = new List<string>();
                    classes.Add("First class");
                    var dates = new List<DateTime>();
                    dates.Add(new DateTime(2016, 10, 20));
                    var passengers = new List<int>();
                    passengers.Add(2);
                    passengers.Add(0);
                    passengers.Add(0);

                    //GetFlightsAPI(path.Select(p => p.CityID).ToList(), classes, dates, passengers, false);

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
        /// <param name="routes"></param>
        /// <param name="classes"></param>
        /// <param name="dates"></param>
        /// <param name="passengers"></param>
        /// <param name="isReturning"></param>
        /// <returns>List of flight lists.
        /// If the flight list for a route is not available, makes it an empty list
        /// If one-way flight, returns a list with 1 object (a list of departure flights), otherwise returns 2 lists (departure and returning flights)
        /// If the whole schedule cannot be found, returns 0</returns>
        public JsonResult GetFlightsAPI(List<string> routes, List<string> classes, List<DateTime> dates, List<int> passengers, bool isReturning)
        {
            try
            {
                //If the routes schedule has less than 1 route, it's a false data. Return 0.
                if (routes.Count > 1)
                {
                    // Posible Schedules: [ Departure flight lists:[ Node 1 flight list: [AR001, AR002,...], Node 2 flight list: [AR034, AR374...], Returning flight lists: [ [....]   ]  ]   ]
                    //List<List<List<Flight>>> result = new List<List<List<Flight>>>();
                    var result = new List<object>();

                    //Number of requested seats
                    int numberOfRequestedSeats = 0;

                    //Number of seats on the planes
                    int numberOfSeats = db.Seats.Count(p => true);

                    foreach (var item in passengers)
                    {
                        numberOfRequestedSeats += item;
                    }

                    FlightScheduleUtilities ru = new FlightScheduleUtilities();

                    #region Departure flight search

                    var searchResult = ru.FindFlights(routes, numberOfRequestedSeats, classes[0], dates[0].Date);
                    var departureFlightLists = searchResult.Where(node => node != null).Select(node => node.Select(flight => new
                    {
                        FlightNumber = flight.FlightNo,
                        Departure = flight.DepartureTime.ToShortTimeString() + " (" + flight.Route.OriginalCity.CityName + ")",
                        Arrival = (flight.DepartureTime.Add(TimeSpan.FromHours(flight.Duration))).ToShortTimeString() + " (" + flight.Route.DestinationCity.CityName + ")",
                        Duration = TimeSpan.FromHours(flight.Duration).ToString("h\\h\\ mm\\m\\ "),
                        Price = flight.CurrentPrice,
                    })).ToList();

                    result.Add(departureFlightLists);

                    #region TEST

                    //var s = "";
                    //foreach (var list in departureFlightLists)
                    //{
                    //    if (list.Count() > 0)
                    //    {
                    //        foreach (var flight in list)
                    //        {
                    //            s += string.Format("{0} - DEP: {1} - Arr: {2} - Duration: {3} - Price: {4}\n", flight.FlightNumber, flight.Departure, flight.Arrival, flight.Duration, flight.Price);
                    //        }
                    //    }
                    //    else
                    //    {
                    //        s += "Not found\n";
                    //    }

                    //    s += "------------------------------------\n";
                    //}

                    #endregion TEST

                    #endregion Departure flight search

                    #region Returning flight search

                    //If returning flight
                    if (isReturning)
                    {
                        var returningPath = new List<string>();
                        returningPath.Add(routes.Last());
                        returningPath.Add(routes.First());

                        searchResult = ru.FindFlights(returningPath, numberOfRequestedSeats, classes[1], dates[1].Date);
                        var returningFlightLists = searchResult.Where(node => node != null).Select(node => node.Select(flight => new
                        {
                            FlightNumber = flight.FlightNo,
                            Departure = flight.DepartureTime.ToShortTimeString() + " (" + flight.Route.OriginalCity.CityName + ")",
                            Arrival = (flight.DepartureTime.Add(TimeSpan.FromHours(flight.Duration))).ToShortTimeString() + " (" + flight.Route.DestinationCity.CityName + ")",
                            Duration = TimeSpan.FromHours(flight.Duration).ToString("h\\h\\ mm\\m\\ "),
                            Price = flight.CurrentPrice,
                        })).ToList();

                        result.Add(returningFlightLists);
                    }

                    #endregion Returning flight search

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

        #region Step 4

        /// <summary>
        /// Login, Register, Recovery
        /// </summary>
        public JsonResult isUserLogged()
        {
            var sSession = (string)Session[Constants.SessionIsLoggedInKey] ?? "false";
            return Json(sSession, JsonRequestBehavior.AllowGet);
        }

        public JsonResult LoginValidation(string UserID, string Password)
        {
            try
            {
                var result = db.Users.Where(p => p.UserID == UserID).Where(p => p.Password == Password).FirstOrDefault();
                if (result != null)
                {
                    Session[Constants.SessionIsLoggedInKey] = "true";
                    //The logged in user ID
                    //REMEMBER: set this value to null when the user logged out.
                    Session[Constants.SessionUserIDKey] = UserID;
                    return Json("1", JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json("0", JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet); ;
            }
        }

        public JsonResult CreateNewUserValidation(string UserID, string Password, string FirstName, string LastName, string Email, bool Gender, string Phone, DateTime DOB, string CreditCard)
        {
            try
            {
                User data = new Models.User();
                data.UserID = UserID;
                data.Password = Password;
                data.FirstName = FirstName;
                data.LastName = LastName;
                data.Email = Email;
                data.Sex = Gender;
                data.DateOfBirth = DOB;
                data.PhoneNumber = Phone;
                data.CreditcardNumber = CreditCard;
                db.Users.Add(data);

                return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException e)
            {
                //Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;

                var outputLines = new List<string>();
                foreach (var eve in e.EntityValidationErrors)
                {
                    outputLines.Add(string.Format(
                        "{0}: Entity of type \"{1}\" in state \"{2}\" has the following validation errors:",
                        DateTime.Now, eve.Entry.Entity.GetType().Name, eve.Entry.State));
                    foreach (var ve in eve.ValidationErrors)
                    {
                        outputLines.Add(string.Format(
                            "- Property: \"{0}\", Error: \"{1}\"",
                            ve.PropertyName, ve.ErrorMessage));
                    }
                }

                return Json(string.Join(",", outputLines.ToArray()), JsonRequestBehavior.AllowGet); ;
            }
        }

        #endregion Step 4

        #region Step 5

        public JsonResult BlockTicketAPI(List<BookedFlightInfo> SelectedFlights, string[] Classes, int[] Passengers)
        {
            try
            {
                var UserID = Session[Constants.SessionUserIDKey];
                if (UserID == null)
                {
                    Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    return Json("You have to sign in first", JsonRequestBehavior.AllowGet);
                }
                else
                {
                    decimal total = 0;
                    //Additional class info for the booked flights before sending to the Reservation utilities
                    foreach (var item in SelectedFlights)
                    {
                        if (item.IsReturning)
                        {
                            item.Class = Classes[1];
                        }
                        else
                        {
                            item.Class = Classes[0];
                        }
                        total += db.Flights.SingleOrDefault(p => p.FlightNo.Equals(item.FlightNumber)).CurrentPrice;
                    }

                    var fsu = new FlightScheduleUtilities();
                    fsu.CreateTicket((string)UserID, SelectedFlights, Passengers, total, TicketStatus.Blocked);

                    return Json(1, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion Step 5
    }
}