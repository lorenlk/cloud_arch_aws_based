# services/srv-c/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class MultRequest(BaseModel):
    value: float
    multiplier: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/multiply")
def multiply(req: MultRequest):
    return {"result": req.value * req.multiplier}