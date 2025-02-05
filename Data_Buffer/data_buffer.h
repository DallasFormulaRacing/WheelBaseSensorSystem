#ifndef DATA_BUFFER_H
#define DATA_BUFFER_H

#include <stdlib.h>
#include <stdint.h>

//create a struct for the buffer
typedef struct Buffer
{
    int capacity;
    int elementsInQueue;
    int* queue;
} Buffer_t;

typedef enum BufferStatus
{
    BUFFER_CREATION_SUCCESS,
    BUFFER_CREATION_FAIL,
    ENQUEUE_SUCCESS,
    ENQUEUE_FAIL,
    DEQUEUE_SUCCESS,
    DEQUEUE_FAIL
} BufferStatus_t;


//this function creates a new buffer of size bufferSize and returns the buffer
//this specific implementation allows the size of the buffer to vary for each buffer created
Buffer_t CreateNewBuffer(int bufferSize);


//this function adds a new data point to the end of the buffer queue, removing the first data point in the queue if the buffer is full
void Enqueue(Buffer_t* b, int dataPoint);


//this function returns the first data point in the buffer and then removes it from the buffer, assuming the buffer is not empty
//returns -1 if the buffer is empty as an error indicator
int Dequeue(Buffer_t* b);

#endif