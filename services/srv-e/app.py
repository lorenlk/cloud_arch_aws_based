# services/srv-e/app.py
from fastapi import FastAPI
from pydantic import BaseModel
import redis
import os

app = FastAPI()

REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
REDIS_PORT = int(os.getenv("REDIS_PORT", 6379))
r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0, decode_responses=True)

class CalcRequest(BaseModel):
    value: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/api/count_double")
def count_double(req: CalcRequest):
    key = f"value:{req.value}"
    r.incr(key)
    count = r.get(key)
    return {"value": req.value, "count": int(count)}