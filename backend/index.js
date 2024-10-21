const express = require("express");
const mysql = require("mysql2");
const app = express();
const port = 3000;

// MySQL connection
const connection = mysql.createConnection({
  host: "your-rds-endpoint",
  user: "your-username",
  password: "your-password",
  database: "sampledb"
});

// Test connection
connection.connect(err => {
  if (err) {
    console.error("Error connecting to MySQL: ", err);
  } else {
    console.log("Connected to MySQL");
  }
});

// API route
app.get("/api", (req, res) => {
  connection.query("SELECT 'Hello from MySQL!' as message", (err, results) => {
    if (err) throw err;
    res.json({ message: results[0].message });
  });
});

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`);
});
