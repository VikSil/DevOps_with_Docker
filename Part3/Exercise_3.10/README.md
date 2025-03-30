## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-4/optimizing-the-image-size#bb0f2fd6-df4a-4887-87c0-9fc97df08a23)

> **EXERCISE 3.10: OPTIMAL SIZED IMAGE**
> 
> Do all or most of the optimizations from security to size for **one** other Dockerfile you have access to, in your own project or for example the ones used in previous "standalone" exercises.
> 
> As answer to the exercise, give the Dockerfile before and after the changes.

## Solution

### Dockerfile before

    FROM python:3.11.5

    WORKDIR /wombo_clicker

    COPY . /wombo_clicker

    RUN pip3 install -r requirements.txt

    RUN apt-get update && apt-get install -y wget unzip && \
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
        apt install -y ./google-chrome-stable_current_amd64.deb && \
        rm google-chrome-stable_current_amd64.deb && \
        apt-get clean

    WORKDIR /wombo_clicker/scripts

    ENTRYPOINT ["python3", "main.py"]

### Dockerfile after

    FROM python:3.12.7-slim as builder

    WORKDIR /wombo_clicker

    RUN useradd -m builduser && chown -R builduser:builduser .
    USER builduser

    COPY requirements.txt .

    RUN pip install --user --upgrade pip --no-cache-dir && \
        pip install  --user -r requirements.txt --no-cache-dir



    FROM python:3.12.7-slim-bullseye

    RUN apt-get update && apt-get install -y wget unzip && \
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
        apt install -y ./google-chrome-stable_current_amd64.deb && \
        rm google-chrome-stable_current_amd64.deb && \
        apt-get clean

    COPY . /wombo_clicker

    RUN useradd -m clicker && chown -R clicker:clicker /wombo_clicker 
        
    COPY --from=builder /home/builduser/.local /home/clicker/.local

    RUN chown -R clicker:clicker /home/clicker

    ENV PATH=/home/clicker/.local:$PATH

    WORKDIR /wombo_clicker/scripts

    USER clicker

    ENTRYPOINT ["python3", "main.py"]


### Image Size Change

![Solution to Exercise 3.10](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.10/Dockerfile_size_change.png)