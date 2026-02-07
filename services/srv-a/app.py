from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class DoubleRequest(BaseModel):
    amount: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/doublevalue")
def double_value(req: DoubleRequest):
    return {"result": req.amount * 2}
