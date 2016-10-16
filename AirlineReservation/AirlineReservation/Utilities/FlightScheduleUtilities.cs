using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class FlightScheduleUtilities
{
    private AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();

    public List<Flight> FindFlightsOfRoute(string originalCityID, string destinationCityID, int passengers, string className, DateTime date)
    {
        var route = db.Routes.FirstOrDefault(p => p.InService && p.OriginalCityID == originalCityID && p.DestinationCityID == destinationCityID);

        if (route == null)
        {
            return null;
        }

        return db.Flights.Where(flight =>

            //Flights of the route
            flight.RouteID == route.RouteID &&

            //Check departure date
            //DateTime.Compare(flight.DepartureTime.Date, date) == 0 &&
            //flight.DepartureTime == date &&
            EntityFunctions.TruncateTime(flight.DepartureTime) == EntityFunctions.TruncateTime(date) &&

            //Check if there are enough available seats of the requested class

            //All the seats of the class
            db.Seats.Where(seat => seat.Class.Equals(className))
            //Except for those seats that have been taken of that flight
            .Except(db.TakenSeats.Where(takenSeat => takenSeat.FlightNo.Equals(flight.FlightNo) && takenSeat.Seat.Class.Equals(className))
                .Select(tk => tk.Seat))

            .Count() >= passengers
        ).ToList();
    }

    public List<List<Flight>> FindFlights(List<string> cityIDSequence, int passengers, string className, DateTime date)
    {
        List<List<Flight>> result = new List<List<Flight>>();
        for (int i = 0; i < cityIDSequence.Count - 1; i++)
        {
            result.Add(FindFlightsOfRoute(cityIDSequence[i], cityIDSequence[i + 1], passengers, className, date));
        }

        return result;
    }
}