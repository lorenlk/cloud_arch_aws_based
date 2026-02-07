# services/srv-c/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class CalcRequest(BaseModel):
    value: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/multiply")
def multiply(req: CalcRequest):
    return {"result": req.value * 3}