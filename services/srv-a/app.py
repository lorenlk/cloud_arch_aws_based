from fastapi import FastAPI
from pydantic import BaseModel
import requests

app = FastAPI()

class CalcRequest(BaseModel):
    value: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/api/calculate")
def calculate(req: CalcRequest):
    multiplier = 2

    # Call service-c internally (private service)
    res = requests.post(
        "http://service-c.demo-app.local:8000/multiply",
        json={"value": req.value, "multiplier": multiplier}
    )
    res.raise_for_status()
    
    remote_data = res.json()
    
    # 5. Retornar al front con el formato que espera (usando "result")
    return {
        "value": req.value,
        "result": remote_data.get("result"),
        "service_c_status": "ok"
    }