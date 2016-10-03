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
        int n;
        double[,] mat; // Graph
        int firstVer, lastVer; // Đỉnh đầu và đỉnh cuối
        int[] label;
        int[] length;
        int[] prev;
        public Dijkstra(int firstVer, int lastVer)
        {
            n = db.Cities.Count();
            this.firstVer = firstVer;
            this.lastVer = lastVer;

            // Ta cần giảm đi 1 cho từng đỉnh
            // Vì mảng bắt đầu từ 0
            firstVer--;
            lastVer--;

            // Cấp phát động
            label = new int[n];
            length = new int[n];
            prev = new int[n];
            mat = new double[n, n];


            // Khởi tạo
            for (int i = 0; i < n; i++)
            {
                label[i] = 1;
                length[i] = -1; // Trọng số = -1 có nghĩa là inf
                prev[i] = -1;
            }
            length[firstVer] = 0;

            List<City> cities = db.Cities.ToList();

            Console.WriteLine("Input:-----------------------");
            // Đọc Graph matrix
            for (int i = 0; i < n; i++)
            {
                if (i == 0)
                {
                    foreach(var cityID in cities.Select(p => p.CityID))
                    {
                        Console.Write("\t"+cityID);
                    }
                    Console.WriteLine();
                }
                for (int j = 0; j < n; j++)
                {
                    if (j == 0)
                    {
                        Console.Write(cities[i].CityID+"\t");
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

                    Console.Write(mat[i,j]+"\t");
                    //fi >> mat[i][j];
                }
                Console.WriteLine();
            }

        }
    }
}
