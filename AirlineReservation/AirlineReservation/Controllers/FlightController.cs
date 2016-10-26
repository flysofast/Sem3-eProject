using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AirlineReservation.Controllers
{
    public class FlightController : Controller
    {
        //
        // GET: /Ticket/
        private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Search for a flight by the flight number
        /// </summary>
        /// <param name="FlightNo"></param>
        /// <returns></returns>
        public JsonResult SearchFlightById(string FlightNo)
        {
            var data = db.Flights.Join(db.Routes,
                                    f => f.RouteID,
                                    r => r.RouteID,
                                    (f, r) => new { Route = r, Flight = f }
                                ).Join(db.Cities,
                                r => r.Route.OriginalCityID,
                                c => c.CityID,
                                (r, c) => new { r.Flight, Route = r, City = c }
                                )
                                .Join(db.Cities,
                                r => r.Route.Route.DestinationCityID,
                                c2 => c2.CityID,
                                (r, c2) => new { r.Flight, r.City, Route = r, City2 = c2 }
                                ).Select(p => new
                                {
                                    p.Flight.FlightNo,
                                    p.Flight.CurrentPrice,
                                    p.Flight.DepartureTime,
                                    p.Flight.Duration,
                                    Original = p.City.CityName,
                                    Destination = p.City2.CityName,
                                }).Where(p => p.FlightNo == FlightNo).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Search for a ticket by its number
        /// </summary>
        /// <param name="TicketNo"></param>
        /// <returns></returns>
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
                                (r, c) => new { r.Ticket, r.Ticket_Flight, r.Flight, Route = r, City = c }
                                )
                                .Join(db.Cities,
                                r => r.Route.Route.DestinationCityID,
                                c2 => c2.CityID,
                                (r, c2) => new { r.Ticket, r.Ticket_Flight, r.Flight, r.City, Route = r, City2 = c2 }
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
                                    p.Route.Route.Route.DestinationCityID,
                                    p.Route.Route.Route.OriginalCityID,
                                    Original = p.City.CityName,
                                    Destination = p.City2.CityName,
                                    p.Ticket_Flight.Ticket_Flight.IsReturning,
                                    Status = p.Ticket.Status == TicketStatus.Blocked ? "Blocked" : p.Ticket.Status == TicketStatus.Confirmed ? "Confirmed" : p.Ticket.Status == TicketStatus.Cancelled ? "Canceled" : "Undefined"
                                }).Where(p => p.TicketNo == TicketNo).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}