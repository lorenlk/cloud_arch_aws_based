# services/srv-b/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class AddRequest(BaseModel):
    value: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/api/add")
def add(req: AddRequest):
    return {"result": req.value + 10}