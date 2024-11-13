//create a struct for the buffer
struct Buffer
{
    int capacity;
    int elementsInQueue;
    int* queue;
};


//this function creates a new buffer of size bufferSize and returns the buffer
//this specific implementation allows the size of the buffer to vary for each buffer created
struct Buffer CreateNewBuffer(int bufferSize)
{
    struct Buffer buffer;
    
    buffer.queue = (int*)malloc(sizeof(int) * bufferSize);
    buffer.capacity = bufferSize;
    buffer.elementsInQueue = 0;

    return buffer;
}


//this function returns the size of the specified buffer
int GetBufferSize(struct Buffer b)
{
    return b.elementsInQueue;
}


//this function adds a new data point to the end of the buffer queue, removing the first data point in the queue if the buffer is full
void AddElementToBuffer(struct Buffer b, int dataPoint)
{
    if (b.elementsInQueue == b.capacity)
    {
        for (int i = 1; i < b.elementsInQueue; i++)
        {
            b.queue[i - 1] = b.queue[i];
        }
        b.elementsInQueue--;

        b.queue[-1] = dataPoint;
        b.elementsInQueue++;
    }
    else
    {
        b.queue[b.elementsInQueue] = dataPoint;
        b.elementsInQueue++;
    }
}


//this function returns the first data point in the buffer and then removes it from the buffer, assuming the buffer is not empty
//returns the max value for int if the buffer is empty as an error indicator
int GetFirstFromBuffer(struct Buffer b)
{
    if (b.elementsInQueue > 0)
    {
        int firstElement = b.queue[0];

        for (int i = 1; i < b.elementsInQueue; i++)
        {
            b.queue[i - 1] = b.queue[i];
        }
        b.elementsInQueue--;

        return firstElement;
    }
    else
    {
        return 2147483647; //returns the max value allowed for int to indicate that the buffer is empty (essentially an error message)
    }
    
}