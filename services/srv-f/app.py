# services/srv-f/app.py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class LogRequest(BaseModel):
    message: str

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/log")
def log(req: LogRequest):
    # Just print for demo
    print(f"LOG: {req.message}")
    return {"status": "logged"}