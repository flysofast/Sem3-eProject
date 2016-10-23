using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AirlineReservation.Models;

namespace AirlineReservation.Controllers
{
    public class TicketController : Controller
    {
        //
        // GET: /Ticket/
        AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult SearchTicketById(int TicketNo)
        {
            var data = db.Tickets.Join(db.Ticket_Flight,
                                t => t.TicketNo,
                                f => f.TicketNo,
                                (t, f) => new { Ticket = t, Ticket_Flight = f })
                                .Join(db.Flights,
                                f => f.Ticket_Flight.FlightNo,
                                p => p.FlightNo,
                                (f, p) => new { f.Ticket, Ticket_Flight = f, Flight = p }
                                )
                                .Join(db.Routes,
                                p => p.Flight.RouteID,
                                r => r.RouteID,
                                (p, r) => new { p.Ticket, p.Ticket_Flight, Flight = p, Route = r }
                                )
                                .Join(db.Cities,
                                r => r.Route.OriginalCityID,
                                c => c.CityID,
                                (r, c) => new { r.Ticket, r.Ticket_Flight, r.Flight, Route = r, City = c}
                                )
                                .Join(db.Cities,
                                r => r.Route.Route.DestinationCityID,
                                c2 => c2.CityID,
                                (r, c2) => new { r.Ticket, r.Ticket_Flight, r.Flight,r.City, Route = r, City2 = c2 }
                                )
                                .Select(p => new
                                {
                                    p.Ticket.TicketNo,
                                    p.Ticket.UserID,
                                    p.Ticket.ConfirmationNo,
                                    p.Ticket.BlockNo,
                                    p.Ticket.CancellationNo,
                                    p.Ticket.Price,
                                    p.Ticket.CreatedDate,
                                    p.Ticket.NumberOfAdults,
                                    p.Ticket.NumberOfChildren,
                                    p.Ticket.NumberOfSeniorCitizens,
                                    p.Ticket_Flight.Ticket_Flight.FlightNo,
                                    p.Flight.Flight.RouteID,
                                    Original = p.City.CityName,
                                    Destination = p.City2.CityName,
                                    Status = p.Ticket.Status == TicketStatus.Blocked ? "Blocked" : p.Ticket.Status == TicketStatus.Confirmed ? "Confirmed" : p.Ticket.Status == TicketStatus.Cancelled ? "Canceled" : "Undefined"
                                }).Where(p => p.TicketNo == TicketNo).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        
        //
        // GET: /Ticket/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Ticket/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Ticket/Create

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
        // GET: /Ticket/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Ticket/Edit/5

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
        // GET: /Ticket/Delete/5
 
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Ticket/Delete/5

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
