FROM python:alpine

RUN pip install Flask

ADD hello.py /tmp/hello.py

WORKDIR /tmp

CMD ["python", "./hello.py"]