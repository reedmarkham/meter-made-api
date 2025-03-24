import pickle

import pandas as pd
import numpy as np
from pydantic import BaseModel
import uvicorn
from fastapi import FastAPI
import lightgbm as lgb

app = FastAPI()

with open('model.pkl', 'rb') as file:
    model = pickle.load(file)

class ParkingSpot(BaseModel):
    d: str
    h: int
    x: float
    y: float

@app.post("/predict")
def predict(data: ParkingSpot):

    to_predict = data.model_dump()
    to_predict['c'] = pd.to_datetime(to_predict['d']).date().day
    to_predict['w'] = pd.to_datetime(to_predict['d']).date().isoweekday()
    to_predict['d'] = pd.to_datetime(to_predict['d']).toordinal()
    to_predict = {k: [to_predict[k]] for k in ['d', 'c', 'w', 'h', 'x', 'y']}
    to_predict = pd.DataFrame(to_predict)

    prediction = model.predict_proba(to_predict)

    return {"probabilities": prediction.tolist()[0], "ticketed": int(np.argmax(prediction[0]))}