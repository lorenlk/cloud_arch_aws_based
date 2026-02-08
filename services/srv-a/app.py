from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI()

class CalcRequest(BaseModel):
    value: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/calculate")
def calculate(req: CalcRequest):
    doubled = req.value * 2

    # Call service-c internally (private service)
    res = requests.post(
        "http://service-c:8000/multiply",
        json={"value": doubled}
    )
    return res.json()