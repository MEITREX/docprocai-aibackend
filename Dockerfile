FROM python:3.12

# store application data in /app in the container volume
WORKDIR /app

RUN apt update -y
RUN apt install -y poppler-utils tesseract-ocr

# only copy the requirements.txt file to the container for now, so that the dependencies can be installed and this
# step can be cached by docker so dependencies don't need to be reinstalled every time the code changes
COPY requirements.txt .

# install dependencies using pip
RUN pip install --no-cache-dir -r requirements.txt

# copy the current directory contents into the container at /app
COPY . .

CMD ["python", "./app.py"]