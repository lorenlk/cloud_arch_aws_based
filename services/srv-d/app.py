# services/srv-d/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class DivRequest(BaseModel):
    value: float
    dividend: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/divide")
def divide(req: DivRequest):
    return {"result": req.value / req.dividend}