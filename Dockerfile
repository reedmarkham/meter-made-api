FROM python:3.9

RUN pip install --no-cache-dir --upgrade -r requirements.txt

ENV APP_HOME=/root
WORKDIR $APP_HOME
COPY /src $APP_HOME/src

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "80"]