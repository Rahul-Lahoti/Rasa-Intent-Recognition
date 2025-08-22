FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
# Option A: bundle the chosen model into the image
RUN rasa train nlu --config config.yml --nlu data/nlu.yml --out models
EXPOSE 5005
CMD ["rasa", "run", "--enable-api", "--model", "models"]
