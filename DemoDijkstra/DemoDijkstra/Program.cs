using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoDijkstra
{
    class Program
    {
        static void Main(string[] args)
        {
            City a = new City();
            a.CityID = "HNN";
            City b = new City();
            b.CityID = "NYK";
            Dijkstra d = new Dijkstra(a,b);
            d.GetShortestPath();
            Console.ReadKey();
        }
    }
}
