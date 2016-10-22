using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class PersonalController : Controller
    {
        private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        //
        // GET: /Personal/

        public ActionResult Index()
        {
            if (Session[Constants.SessionUserIDKey] == null)
            {
                this.Response.Redirect("/");
            }
            return View();
        }

        public ActionResult SignOut()
        {
            Session[Constants.SessionUserIDKey] = null;
            Session[Constants.SessionIsAdminLogged] = null;
            return Index();
        }

        public JsonResult GetCurrentUserInfor()
        {
            var userID = (string)(Session[Constants.SessionUserIDKey]);
            var data = db.Users.Select(p => new { p.CreditcardNumber, p.DateOfBirth, p.Email, p.FirstName, p.IsAdmin, p.LastName, p.Password, p.PhoneNumber, p.Sex, p.UserID }).Where(p => p.UserID == userID).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCurrentUserTicketList()
        {
            var userID = (string)(Session[Constants.SessionUserIDKey]);
            var data = db.Tickets.Select(p => new { p.TicketNo, p.UserID, p.ConfirmationNo, p.BlockNo, p.CancellationNo, p.Price, p.CreatedDate, p.NumberOfAdults, p.NumberOfChildren, p.NumberOfSeniorCitizens, p.Status }).Where(p => p.UserID == userID).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CheckTicketCode(int TicketNo, string Code, int Mode)
        {
            var userID = (string)(Session[Constants.SessionUserIDKey]);
            //var data = new Ticket();
            switch (Mode)
            {
                case TicketStatus.Confirmed:
                    var data = db.Tickets.Select(p => new { p.TicketNo, p.UserID, p.ConfirmationNo }).Where(p => p.TicketNo == TicketNo).Where(p => p.UserID == userID).Where(p => p.ConfirmationNo == Code).FirstOrDefault();
                    return Json(data == null ? 0 : 1, JsonRequestBehavior.AllowGet);

                case TicketStatus.Blocked:
                    //data = db.Tickets.Where(p => p.UserID == userID).Where(p => p.BlockNo == Code).FirstOrDefault();
                    break;

                case TicketStatus.Cancelled:
                    //data = db.Tickets.Where(p => p.UserID == userID).Where(p => p.CancellationNo == Code).FirstOrDefault();
                    break;

                default:
                    break;
            }
            return Json(0, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateUserValidation(string UserID, string FirstName, string LastName, string Email, bool Gender, string Phone, DateTime DOB, string CreditCard)
        {
            try
            {
                var userID = (string)(Session[Constants.SessionUserIDKey]);
                User data = db.Users.Where(p => p.UserID == userID).FirstOrDefault();
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
    }
}