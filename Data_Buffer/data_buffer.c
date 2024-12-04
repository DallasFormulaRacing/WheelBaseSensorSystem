#include "data_buffer.h"


//this function creates a new buffer of size bufferSize and returns the buffer
//this specific implementation allows the size of the buffer to vary for each buffer created
Buffer_t CreateNewBuffer(int bufferSize)
{
    Buffer_t buffer;
    
    int array[bufferSize];
    
    buffer.queue = array;
    buffer.capacity = bufferSize;
    buffer.elementsInQueue = 0;

    return buffer;
}


//this function adds a new data point to the end of the buffer queue, removing the first data point in the queue if the buffer is full
void Enqueue(Buffer_t* b, int dataPoint)
{
    if (b->elementsInQueue == b->capacity)
    {
        for (int i = 1; i < b->elementsInQueue; i++)
        {
            b->queue[i - 1] = b->queue[i];
        }
        b->elementsInQueue--;

        b->queue[b->elementsInQueue] = dataPoint;
        b->elementsInQueue++;
    }
    else
    {
        b->queue[b->elementsInQueue] = dataPoint;
        b->elementsInQueue++;
    }
}


//this function returns the first data point in the buffer and then removes it from the buffer, assuming the buffer is not empty
//returns -1 if the buffer is empty as an error indicator
int Dequeue(Buffer_t* b)
{
    int* msg;
    if (b->elementsInQueue > 0)
    {
        int firstElement = b->queue[0];

        for (int i = 1; i < b->elementsInQueue; i++)
        {
            b->queue[i - 1] = b->queue[i];
        }
        b->elementsInQueue--;

        msg = firstElement;
    }
    else
    {
        msg = DEQUEUE_FAIL;
    }
}