FROM python:3.8-slim

RUN groupadd -r counter && useradd -r -g counter counter 
WORKDIR /app
COPY . /app
RUN ls -l && pwd
RUN pip install --trusted-host pypi.python.org -r requirements.txt
USER counter
EXPOSE 8080

CMD ["python", "app.py"]