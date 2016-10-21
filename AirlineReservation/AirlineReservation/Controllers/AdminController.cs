using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AirlineReservation.Models;

namespace AirlineReservation.Controllers
{
    public class AdminController : Controller
    {
        //
        // GET: /Admin/
        AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult GetAdministratorList()
        {
            var data = db.Users.Select(p => new { p.CreditcardNumber, p.DateOfBirth, p.Email, p.FirstName, p.IsAdmin, p.LastName, p.PhoneNumber, p.Sex, p.UserID }).Where(p => p.IsAdmin == true).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetNormalUserList()
        {
            var data = db.Users.Select(p => new { p.CreditcardNumber, p.DateOfBirth, p.Email, p.FirstName, p.IsAdmin, p.LastName, p.PhoneNumber, p.Sex, p.UserID }).Where(p => p.IsAdmin == false).ToList();
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

        public JsonResult GetAllRoute()
        {
            var data = db.Routes.Select(p => new { p.RouteID, p.OriginalCityID, p.DestinationCityID, p.Distance, p.InService}).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetAllFlight()
        {
            var data = db.Flights.Select(p => new { p.FlightNo, p.CancellationFee, p.CurrentPrice, p.DepartureTime, p.Duration, p.RouteID }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetFlightByFlightNo(string FlightNo)
        {
            var data = db.Flights.Select(p => new { p.FlightNo, p.CancellationFee, p.CurrentPrice, p.DepartureTime, p.Duration, p.RouteID }).Where(p => p.FlightNo == FlightNo).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateFlight(string FlightNo, decimal Price, DateTime DepartureTime, int RouteID, float CancellationFee, float Duration)
        {
            var data = db.Flights.Where(p=>p.FlightNo == FlightNo).FirstOrDefault();
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
        //
        // GET: /Admin/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Admin/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Admin/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        
        //
        // GET: /Admin/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Admin/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Admin/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
