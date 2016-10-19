using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AirlineReservation.Models;

namespace AirlineReservation.Controllers
{    
    public class PersonalController : Controller
    {
        AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        //
        // GET: /Personal/

        public ActionResult Index()
        {
            var sSession = (string)Session[Constants.SessionIsLoggedInKey] ?? "false";
            System.Console.Write(sSession);
            if (sSession == "false")
            {
                this.Response.Redirect("Home");
            }
            return View();
        }

        public JsonResult GetCurrentUserInfor()
        {
            var userID = (string)(Session[Constants.SessionUserIDKey]);
            var data = db.Users.Where(p => p.UserID == userID).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateUserValidation(string UserID, string FirstName, string LastName, string Email, bool Gender, string Phone, DateTime DOB, string CreditCard)
        {
            try
            {
                var userID = (string)(Session[Constants.SessionUserIDKey]);
                User data = db.Users.Where(p => p.UserID == userID).FirstOrDefault() ;
                data.FirstName = FirstName;
                data.LastName = LastName;
                data.Email = Email;
                data.Sex = Gender;
                data.DateOfBirth = DOB;
                data.PhoneNumber = Phone;
                data.CreditcardNumber = CreditCard;

                return Json(db.SaveChanges(), JsonRequestBehavior.AllowGet);
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException e)
            {
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

        public ActionResult AirplantSeat()
        {
            return View();
        }

        //
        // GET: /Personal/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Personal/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Personal/Create

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
        // GET: /Personal/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Personal/Edit/5

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
        // GET: /Personal/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Personal/Delete/5

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
