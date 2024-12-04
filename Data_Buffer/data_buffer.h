#include <stdlib.h>
#include <stdint.h>

//create a struct for the buffer
struct Buffer
{
    int capacity;
    int elementsInQueue;
    int* queue;
};


//this function creates a new buffer of size bufferSize and returns the buffer
//this specific implementation allows the size of the buffer to vary for each buffer created
struct Buffer CreateNewBuffer(int bufferSize);


//this function adds a new data point to the end of the buffer queue, removing the first data point in the queue if the buffer is full
void Enqueue(struct Buffer b, int dataPoint);


//this function returns the first data point in the buffer and then removes it from the buffer, assuming the buffer is not empty
//returns the max value for int if the buffer is empty as an error indicator
int Dequeue(struct Buffer b);