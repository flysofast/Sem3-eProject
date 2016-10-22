using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        public ActionResult Index()
        {
            if (Session[Constants.SessionUserIDKey] == null)
            {
                Response.Redirect("Home");
            }
            return View();
        }

        public JsonResult GetAdministratorList()
        {
            var data = db.Users.Select(p => new
            {
                p.CreditcardNumber,
                p.DateOfBirth,
                p.Email,
                p.FirstName,
                p.IsAdmin,
                p.LastName,
                p.PhoneNumber,
                p.Sex,
                p.UserID
            }).Where(p => p.IsAdmin == true).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNormalUserList()
        {
            var data = db.Users.Select(p => new
            {
                p.CreditcardNumber,
                p.DateOfBirth,
                p.Email,
                p.FirstName,
                p.IsAdmin,
                p.LastName,
                p.PhoneNumber,
                p.Sex,
                p.UserID
            }).Where(p => p.IsAdmin == false).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateFlight(string FlightNo, decimal Price, DateTime DepartureTime, int RouteID, float CancellationFee, float Duration)
        {
            var data = new Flight();
            data.FlightNo = FlightNo;
            data.CurrentPrice = Price;
            data.DepartureTime = DepartureTime;
            data.RouteID = RouteID;
            data.CancellationFee = CancellationFee;
            data.Duration = Duration;
            db.Flights.Add(data);
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateCity(string CityID, string CityName, bool InService)
        {
            var data = new City();
            data.CityID = CityID;
            data.CityName = CityName;
            data.InService = InService;
            db.Cities.Add(data);
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateCity(string CityID, string CityName, bool InService)
        {
            var data = db.Cities.Where(p => p.CityID == CityID).FirstOrDefault();
            data.CityName = CityName;
            data.InService = InService;
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCityByCityID(string CityID)
        {
            var data = db.Cities.Select(p => new
            {
                p.CityID,
                p.CityName,
                p.InService,
            }).Where(p => p.CityID == CityID).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRouteByRouteID(int RouteID)
        {
            var data = db.Routes.Select(p => new
            {
                p.RouteID,
                p.Distance,
                p.DestinationCityID,
                p.OriginalCityID,
                p.InService,
            }).Where(p => p.RouteID == RouteID).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CreateRoute(string OriginalCityID, string DestinateCityID, int Distance, bool InService)
        {
            var data = new Route();
            data.OriginalCityID = OriginalCityID;
            data.DestinationCityID = DestinateCityID;
            data.Distance = Distance;
            data.InService = InService;
            db.Routes.Add(data);
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateRoute(int RouteID, string OriginalCityID, string DestinateCityID, int Distance, bool InService)
        {
            var data = db.Routes.Where(p => p.RouteID == RouteID).FirstOrDefault();
            data.DestinationCityID = DestinateCityID;
            data.Distance = Distance;
            data.InService = InService;
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllRoute()
        {
            var data = db.Routes.Select(p => new
            {
                p.RouteID,
                OriginalCity = p.OriginalCity.CityName,
                DestinationCity = p.DestinationCity.CityName,
                p.InService,
                p.Distance
            }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllFlight()
        {
            var data = db.Flights.Select(p => new
            {
                p.FlightNo,
                p.CancellationFee,
                p.CurrentPrice,
                p.DepartureTime,
                p.Duration,
                OriginalCity = p.Route.OriginalCity.CityID,
                DestinationCity = p.Route.DestinationCity.CityID
            }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllCity()
        {
            var data = db.Cities.Select(p => new
            {
                p.CityID,
                p.CityName,
                p.InService
            }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetFlightByFlightNo(string FlightNo)
        {
            var data = db.Flights.Select(p => new
            {
                p.FlightNo,
                p.CancellationFee,
                p.CurrentPrice,
                p.DepartureTime,
                p.Duration,
                p.RouteID
            }).Where(p => p.FlightNo == FlightNo).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateFlight(string FlightNo, decimal Price, DateTime DepartureTime, int RouteID, float CancellationFee, float Duration)
        {
            var data = db.Flights.Where(p => p.FlightNo == FlightNo).FirstOrDefault();
            data.CurrentPrice = Price;
            data.DepartureTime = DepartureTime;
            data.RouteID = RouteID;
            data.CancellationFee = CancellationFee;
            data.Duration = Duration;
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateAdmin(string UserID, bool IsAdmin)
        {
            var data = db.Users.Where(p => p.UserID == UserID).FirstOrDefault();
            data.IsAdmin = IsAdmin;
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllSeat()
        {
            var data = db.Seats.Select(p => new
            {
                p.SeatID,
                p.Class,
            }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSeatByClassType(string ClassType)
        {
            var data = db.Seats.Select(p => new
            {
                p.SeatID,
                p.Class,
            }).Where(p => p.Class == ClassType).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateSeat(string[] SeatID,string ClassType)
        {
            foreach (string element in SeatID)
            {
                var data = db.Seats.Where(p => p.SeatID == element).FirstOrDefault();
                data.Class = ClassType;
                db.SaveChanges();
            }
            
            return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
        }

    }
}