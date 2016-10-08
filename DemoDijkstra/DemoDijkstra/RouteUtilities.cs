using DemoDijkstra;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

class RouteUtilities
{
    AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
    public List<Flight> FindFlightsOfRoute(City originalCity, City destinationCity)
    {
        var route = db.Routes.FirstOrDefault(p => p.InService && p.OriginalCityID == originalCity.CityID && p.DestinationCityID == destinationCity.CityID);

        if (route == null)
        {
            return null;
        }

        return db.Flights.Where(p => p.RouteID == route.RouteID && p.DepartureTime >= new DateTime()).ToList();
    }

    public List<List<Flight>> FindFlight(List<City> citySequence)
    {
        List<List<Flight>> result = new List<List<Flight>>();
        for (int i = 0; i < citySequence.Count-1; i++)
        {
            result.Add(FindFlightsOfRoute(citySequence[i], citySequence[i + 1]));
        }

        return result;
    }
}