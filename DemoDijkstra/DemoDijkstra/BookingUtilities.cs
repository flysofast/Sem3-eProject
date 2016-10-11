using DemoDijkstra;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class BookingUtilities
{
    AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
    public void BookTicket(Flight flight, List<Seat> bookedSeats)
    {
        var currentUser = GetCurrentUser();
        if (currentUser == null)
        {
            Console.WriteLine("The user has to login first!");
            return;
        }

        if (db.Seats.Count() - db.TakenSeats.Where(p => p.FlightNo.Equals(flight.FlightNo)).ToList().Count < bookedSeats.Count)
        {
            Console.WriteLine("There are not enough available seats!");
            return;
        }

        if (bookedSeats.Any(p=>p.TakenSeats.Any(q=>q.FlightNo.Equals(flight.FlightNo))))
        {
            Console.WriteLine("Some of those seats are taken");
            return;
        }

        Ticket ticket = new Ticket();
        ticket.Price = flight.CurrentPrice;
        ticket.User = GetCurrentUser();
        ticket.CreatedDate = DateTime.Now;
        

        foreach (var item in bookedSeats)   
        {
            var takenseat = new TakenSeat();
            takenseat.FlightNo = flight.FlightNo;
            //takenseat.TicketNo

        }

      


    }


    User GetCurrentUser()
    {
        throw new NotImplementedException();
    }
}
