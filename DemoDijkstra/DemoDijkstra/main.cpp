//
//  main.cpp
//  DemoDijisktra
//
//  Created by Le Hai Nam on 10/3/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

#include <iostream>
#include "Dijkstra.cpp"
const std::string s("/Users/lehainam/OneDrive/Projects/My projects/DemoDijisktra/DemoDijisktra/input.txt");
int main(int argc, const char * argv[]) {
    std::cout << "Hello, World!\n";
  // insert code here...
  Dijkstra *a = new Dijkstra("/Users/lehainam/OneDrive/Projects/My projects/DemoDijisktra/DemoDijisktra/input.txt");
  a->findMinPath("/Users/lehainam/OneDrive/Projects/My projects/DemoDijisktra/DemoDijisktra/output.txt");

    return 0;
}

