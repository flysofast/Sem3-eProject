using AirlineReservation.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoDijkstra
{
    class Dijkstra
    {

        AirlineReservationSystemEntities db = new AirlineReservationSystemEntities();
        List<City> cities;
        double[,] mat; // Graph
        int firstVer, lastVer; // Original vertex and destination vertex
        int[] label;
        double[] length;
        int[] prev;

        public Dijkstra(string originalCityID, string destinationCityID)
        {
            cities = db.Cities.Where(p => p.InService).ToList();
            firstVer = cities.IndexOf(cities.FirstOrDefault(p => p.CityID == originalCityID));
            lastVer = cities.IndexOf(cities.FirstOrDefault(p => p.CityID == destinationCityID));

            if (firstVer == -1 || lastVer == -1)
            {
                Console.WriteLine("Invalid city IDs");
                throw new KeyNotFoundException("There's no city matches one or all of these IDs");
            }

            // Initialize
            label = new int[cities.Count];
            length = new double[cities.Count];
            prev = new int[cities.Count];
            mat = new double[cities.Count, cities.Count];

            for (int i = 0; i < cities.Count; i++)
            {
                label[i] = 1;
                length[i] = -1; // -1 means infinite
                prev[i] = -1;
            }
            length[firstVer] = 0;



            Console.WriteLine("Input:-----------------------");
            // Read Graph matrix
            for (int i = 0; i < cities.Count; i++)
            {
                if (i == 0)
                {
                    foreach (var cityID in cities.Select(p => p.CityID))
                    {
                        Console.Write("\t" + cityID);
                    }
                    Console.WriteLine();
                }
                for (int j = 0; j < cities.Count; j++)
                {
                    if (j == 0)
                    {
                        Console.Write(cities[i].CityID + "\t");
                    }
                    if (i == j)
                    {
                        mat[i, j] = 0;
                    }
                    else
                    {
                        var route = cities[i].RoutesAsOriginal.SingleOrDefault(p => p.InService && p.DestinationCity == cities[j]);
                        if (route != null)
                        {
                            mat[i, j] = route.Distance;
                        }
                        else
                        {
                            mat[i, j] = 0;
                        }
                    }

                    Console.Write(mat[i, j] + "\t");
                }
                Console.WriteLine();
            }

        }

        /// <summary>
        /// Use Dijkstra algorithm to find the shortest path
        /// </summary>
        /// <returns>true if found, false if not</returns>
        bool FindShortestPath()
        {
            // While the lastVer hasn't been marked 
            while (label[lastVer] == 1)
            {
                double min = -1;
                int vertex = -1;

                // Find shortest path
                for (int i = 0; i < cities.Count; i++)
                {
                    if (label[i] == 1 && length[i] != -1 && (length[i] < min || min == -1))
                    {
                        min = length[i];
                        vertex = i;
                    }
                }

                // If there's no min value then no route can be found from firstVer to lastVer
                if (min == -1)
                {
                    return false;
                }

                // Mark the vertex
                length[vertex] = min;
                label[vertex] = 0;


                for (int i = 0; i < cities.Count; i++)
                {
                    // If the vertext hasn't been marked and there is a route from vertext -> i
                    if (label[i] == 1 && mat[vertex, i] != 0)
                    {
                        // If the path is shorter than the recorded found path in length array
                        if (length[i] == -1 || length[i] > length[vertex] + mat[vertex, i])
                        {
                            length[i] = length[vertex] + mat[vertex, i];
                            // Remember the step
                            prev[i] = vertex;
                        }
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// Get the shortest path between the 2 cities
        /// </summary>
        /// <returns>Empty list if there's no path found. Otherwise returns shortest path as an ordered list of cities</returns>
        public List<City> GetShortestPath()
        {
            List<City> result = new List<City>();
            var originalID = cities[firstVer].CityID;
            var destinationID = cities[lastVer].CityID;

            //If there is a direct route between the two cities then return them as the shortest path
           
            if (db.Routes.FirstOrDefault(p => p.InService
              && p.OriginalCityID.Equals(originalID)
              && p.DestinationCityID.Equals(destinationID)) != null)
            {
                result.Add(cities[firstVer]);
                result.Add(cities[lastVer]);
                return result;
            }

            if (!FindShortestPath())
            {
                Console.WriteLine("There's no route between these cities");
            }
            else
            {
                // Invert tracking
                int k = lastVer;
                while (k != firstVer)
                {
                    result.Add(cities[k]);
                    //Console.Write(cities[k].CityID + "<------------");
                    //fo << (k + 1) << " <--- ";
                    // Tìm ngược lại bằng mảng prev lưu đỉnh trước đó
                    k = prev[k];
                }
                //Console.Write(cities[firstVer].CityID);
                result.Add(cities[firstVer]);
                result.Reverse();
                //foreach (var item in result)
                //{
                //    Console.WriteLine(item.CityID);
                //}
            }

            return result;
        }
    }

}
