using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Transactions;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class PersonalController : Controller
    {
        private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        /// <summary>
        /// Check if the user has logged in
        /// </summary>
        private void VerifyLogin()
        {
            if (Session[Constants.SessionUserIDKey] == null)
            {
                this.Response.Redirect("/");
            }
        }

        public ActionResult Index()
        {
            VerifyLogin();
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
            VerifyLogin();
            var userID = (string)(Session[Constants.SessionUserIDKey]);
            var data = db.Users.Select(p => new
            {
                p.CreditcardNumber,
                p.DateOfBirth,
                p.Email,
                p.FirstName,
                p.IsAdmin,
                p.LastName,
                p.Password,
                p.PhoneNumber,
                p.Sex,
                p.UserID
            }).Where(p => p.UserID == userID).FirstOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCurrentUserTicketList()
        {
            VerifyLogin();
            try
            {
                var userID = (string)(Session[Constants.SessionUserIDKey]);

                var tickets = db.Tickets.Where(p => p.UserID.Equals(userID)).ToList();

                var activeTickets = tickets.Where(p => p.Ticket_Flight.Single(q => q.SequenceNo == 0 && q.IsReturning == false).Flight.DepartureTime > DateTime.Now &&
                (p.Status == TicketStatus.Blocked || p.Status == TicketStatus.Confirmed)).Select(p => new
                {
                    p.TicketNo,
                    p.UserID,
                    p.ConfirmationNo,
                    p.BlockNo,
                    p.CancellationNo,
                    p.Price,
                    p.CreatedDate,
                    p.NumberOfAdults,
                    p.NumberOfChildren,
                    p.NumberOfSeniorCitizens,
                    StatusCode = p.Status,
                    Status = p.Status == TicketStatus.Blocked ? "Blocked" : p.Status == TicketStatus.Confirmed ? "Confirmed" : p.Status == TicketStatus.Cancelled ? "Canceled" : "Undefined"
                }).ToList();

                if (tickets.Count() == 0)
                {
                    throw new Exception("You do not have any active ticket");
                }

                return Json(activeTickets, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Take suitable action with the ticket and action code
        /// </summary>
        /// <param name="ticketNo"></param>
        /// <param name="actionCode">Confirm or Cancel</param>
        /// <returns></returns>
        public JsonResult TakeActionForTicket(int ticketNo, int actionCode)
        {
            VerifyLogin();

            if (actionCode != TicketStatus.Cancelled && actionCode != TicketStatus.Confirmed)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json("The requested action is not valid", JsonRequestBehavior.AllowGet);
            }

            using (var transaction = new TransactionScope())
            {
                try
                {
                    var ticket = db.Tickets.Single(p => p.TicketNo.Equals(ticketNo));
                    string generatedCode = actionCode.ToString("D2") + ticket.TicketNo.ToString();

                    FlightScheduleUtilities fu = FlightScheduleUtilities.GetSharedInstance();

                    if (actionCode == TicketStatus.Confirmed)
                    {
                        ticket.ConfirmationNo = generatedCode;
                        fu.ChargeUser(ticket.UserID, ticket.Price);

                    }
                    else if (actionCode == TicketStatus.Cancelled)
                    {
                        ticket.CancellationNo = generatedCode;
                        fu.ChargeUser(ticket.UserID, Convert.ToDecimal(fu.GetCancellationFee(ticket)));

                    }
                    ticket.Status = actionCode;

                    db.SaveChanges();

                    transaction.Complete();
                    return Json(1, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    return Json(ex.Message, JsonRequestBehavior.AllowGet);
                }
            }
        }

        /// <summary>
        /// Get cancellation fee
        /// </summary>
        /// <param name="ticketNo"></param>
        /// <returns></returns>
        public JsonResult GetCancellationFeeAPI(int ticketNo)
        {
            try
            {
                var ticket = db.Tickets.Single(p => p.TicketNo.Equals(ticketNo));
                FlightScheduleUtilities fu = FlightScheduleUtilities.GetSharedInstance();

                return Json(fu.GetCancellationFee(ticket), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(ex.Message, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult UpdateUserValidation(string UserID, string FirstName, string LastName, string Email, bool Gender, string Phone, DateTime DOB, string CreditCard)
        {
            VerifyLogin();
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
            VerifyLogin();
            return View();
        }
    }
}