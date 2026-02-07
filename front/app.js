async function doubleValue() {
  try {
    const res = await fetch("http://localhost:8000/doublevalue", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ amount: 100 })
    });
    const data = await res.json();
    alert(`Value: ${data.result}`);
  } catch (err) {
    console.error(err);
    alert("Failed to call backend");
  }
}