FROM python:3.11.2

WORKDIR /app

COPY . /app

EXPOSE 6453

CMD ["python", "/app/main.py"]
