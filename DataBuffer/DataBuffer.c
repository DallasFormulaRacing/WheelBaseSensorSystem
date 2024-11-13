struct Buffer
{
    int capacity;
    int elementsInQueue;
    int* queue;
};

struct Buffer CreateNewBuffer(int bufferSize)
{
    struct Buffer buffer;
    
    buffer.queue = (int*)malloc(sizeof(int) * bufferSize);
    buffer.capacity = bufferSize;
    buffer.elementsInQueue = 0;

    return buffer;
}

int GetBufferSize(struct Buffer b)
{
    return b.elementsInQueue;
}

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