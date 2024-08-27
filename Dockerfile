FROM python:3.11.2

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir --requirement requirements.txt

EXPOSE 6453

VOLUME ["/app/photos"]

CMD ["python", "/app/main.py"]
