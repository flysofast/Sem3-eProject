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

            try
            {
                Dijkstra d = new Dijkstra("HNN", "NYK");
                d.GetShortestPath();
            }
            catch (KeyNotFoundException ex)
            {
                Console.WriteLine(ex.Message);
            }
            Console.ReadKey();
        }
    }
}
