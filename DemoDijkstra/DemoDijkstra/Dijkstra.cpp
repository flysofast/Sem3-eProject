#include <fstream>
class Dijkstra
{
private:
  int n;
  int **mat; // Graph
  int firstVer, lastVer; // Đỉnh đầu và đỉnh cuối
  int* label;
  int* length;
  int* prev;
  bool createPath()
  {
    // Chừng nào đỉnh lastVer vẫn chưa được đánh dấu thì ta còn xét
    while (label[lastVer] == 1)
    {
      int min = -1;
      int vertex = -1;

      // Tìm min length
      for (int i = 0; i < n; i++)
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


      for (int i = 0; i < n; i++)
      {
        // Nếu đỉnh chưa được đánh dấu, và có đường đi từ vertex -> i
        if (label[i] == 1 && mat[vertex][i] != 0)
        {
          // Nếu đường đi từ vertex -> i ngắn hơn đường đi đã lưu trong mảng length
          if (length[i] == -1 || length[i] > length[vertex] + mat[vertex][i])
          {
            length[i] = length[vertex] + mat[vertex][i];
            // Tạo vết chân
            prev[i] = vertex;
          }
        }
      }
    }
    return true;
  }

public:
  Dijkstra(std::string filePath)
  {
    std::ifstream fi(filePath);

    // Đọc số đỉnh trong file
    fi >> n;

    // Đọc đỉnh đầu và cuối
    fi >> firstVer >> lastVer;

    // Ta cần giảm đi 1 cho từng đỉnh
    // Vì mảng bắt đầu từ 0
    firstVer--;
    lastVer--;

    // Cấp phát động
    label = new int[n];
    length = new int[n];
    prev = new int[n];
    mat = new int*[n];
    for (int i = 0; i < n; i++) mat[i] = new int[n];

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



  void findMinPath(std::string filePath)
  {
    std::ofstream fo(filePath);
    bool pathExists = this->createPath();
    if (!pathExists) fo << "Khong the tim thay duong di!";
    else
    {
      // Dò ngược từ đỉnh cuối về đỉnh đầu
      int k = lastVer;
      while (k != firstVer)
      {
        fo << (k + 1) << " <--- ";
        // Tìm ngược lại bằng mảng prev lưu đỉnh trước đó
        k = prev[k];
      }
      fo << (firstVer + 1);
    }
  }
};


