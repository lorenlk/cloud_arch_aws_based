async function doubleValue() {
  const value = parseFloat(document.getElementById("doubleInput").value);
  try {
    const res = await fetch("/api/calculate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ value: value })
    });
    const data = await res.json();
    document.getElementById("doubleResult").textContent = `Result: ${data.result}`;
  } catch (err) {
    console.error(err);
    alert("Failed to call service-a");
  }
}

async function addValue() {
  const value = parseFloat(document.getElementById("addInput").value);
  try {
    const res = await fetch("/api/add", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ value: value })
    });
    const data = await res.json();
    document.getElementById("addResult").textContent = `Result: ${data.result}`;
  } catch (err) {
    console.error(err);
    alert("Failed to call service-b");
  }
}

async function countDouble() {
  const value = parseFloat(document.getElementById("countInput").value);
  try {
    const res = await fetch("/api/count_double", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ value: value })
    });
    const data = await res.json();
    document.getElementById("countResult").textContent = `Result: ${data.result}`;
  } catch (err) {
    console.error(err);
    alert("Failed to call service-e");
  }
}
