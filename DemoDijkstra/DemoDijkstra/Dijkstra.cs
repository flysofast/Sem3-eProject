using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoDijkstra
{
    class Dijkstra
    {
        int n;
        int[,] mat; // Graph
        int firstVer, lastVer; // Đỉnh đầu và đỉnh cuối
        int[] label;
        int[] length;
        int[] prev;
        Dijkstra(int verticesCount, int firstVer, int lastVer)
        {
            n = verticesCount;
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
            mat = new int[n, n];


            // Khởi tạo
            for (int i = 0; i < n; i++)
            {
                label[i] = 1;
                length[i] = -1; // Trọng số = -1 có nghĩa là inf
                prev[i] = -1;
            }
            length[firstVer] = 0;

            // Đọc Graph matrix
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    fi >> mat[i][j];
                }
            }

            fi.close();
        }
    }
}
