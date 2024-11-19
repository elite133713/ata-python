FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app ./app

ENV FLASK_APP=app:create_app
ENV FLASK_RUN_PORT=5000
ENV FLASK_ENV=development

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]