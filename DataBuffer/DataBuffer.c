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
        DeleteFromBuffer(b);
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
    int firstElement = b.queue[0];

    DeleteFromBuffer(b);

    return firstElement;
}

void DeleteFromBuffer(struct Buffer b)
{
    for (int i = 1; i < b.elementsInQueue; i++)
    {
        b.queue[0] = b.queue[i];
    }
    b.elementsInQueue--;
}