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