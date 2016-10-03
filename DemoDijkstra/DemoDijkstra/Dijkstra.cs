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
        int firstVer, lastVer; // Đỉnh đầu và đỉnh cuối
        int[] label;
        double[] length;
        int[] prev;

        public Dijkstra(City originalCity, City destinationCity)
        {
            cities = db.Cities.ToList();
            firstVer = cities.IndexOf(cities.First(p => p.CityID == originalCity.CityID));
            lastVer = cities.IndexOf(cities.First(p => p.CityID == destinationCity.CityID));

            // Cấp phát động
            label = new int[cities.Count];
            length = new double[cities.Count];
            prev = new int[cities.Count];
            mat = new double[cities.Count, cities.Count];


            // Khởi tạo
            for (int i = 0; i < cities.Count; i++)
            {
                label[i] = 1;
                length[i] = -1; // Trọng số = -1 có nghĩa là inf
                prev[i] = -1;
            }
            length[firstVer] = 0;



            Console.WriteLine("Input:-----------------------");
            // Đọc Graph matrix
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
                        var route = cities[i].RoutesAsOriginal.SingleOrDefault(p => p.DestinationCity == cities[j]);
                        if (route != null)
                        {
                            mat[i, j] = route.Distance;
                        }
                        else
                        {
                            //mat[i, j] = 0;
                        }
                    }

                    Console.Write(mat[i, j] + "\t");
                    //fi >> mat[i][j];
                }
                Console.WriteLine();
            }

        }


        bool FindShortestPath()
        {
            // Chừng nào đỉnh lastVer vẫn chưa được đánh dấu thì ta còn xét
            while (label[lastVer] == 1)
            {
                double min = -1;
                int vertex = -1;

                // Tìm min length
                for (int i = 0; i < cities.Count; i++)
                {
                    if (label[i] == 1 && length[i] != -1 && (length[i] < min || min == -1))
                    {
                        min = length[i];
                        vertex = i;
                    }
                }

                // Nếu ta không tìm được min nào, có nghĩa là không có đường đi từ firstVer -> lastVer
                if (min == -1)
                {
                    return false;
                }

                // Đánh dấu đỉnh vertex
                length[vertex] = min;
                label[vertex] = 0;


                for (int i = 0; i < cities.Count; i++)
                {
                    // Nếu đỉnh chưa được đánh dấu, và có đường đi từ vertex -> i
                    if (label[i] == 1 && mat[vertex, i] != 0)
                    {
                        // Nếu đường đi từ vertex -> i ngắn hơn đường đi đã lưu trong mảng length
                        if (length[i] == -1 || length[i] > length[vertex] + mat[vertex, i])
                        {
                            length[i] = length[vertex] + mat[vertex, i];
                            // Tạo vết chân
                            prev[i] = vertex;
                        }
                    }
                }
            }
            return true;
        }

     
        public void GetShortestPath()
        {
            bool pathExists = this.FindShortestPath();
            if (!pathExists)
            {
                Console.WriteLine("There's no route between these cities");
            }
            else
            {
                // Dò ngược từ đỉnh cuối về đỉnh đầu
                int k = lastVer;
                while (k != firstVer)
                {
                    Console.Write(cities[k].CityID + "<------------");
                    //fo << (k + 1) << " <--- ";
                    // Tìm ngược lại bằng mảng prev lưu đỉnh trước đó
                    k = prev[k];
                }
                //fo << (firstVer + 1);
                Console.Write(cities[firstVer].CityID);
            }
        }
    }

}
