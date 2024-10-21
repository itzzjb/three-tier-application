const express = require("express");
const mysql = require("mysql2");
const app = express();
const port = 3000;

// MySQL connection
const connection = mysql.createConnection({
  // We are going to use github secrets to store the db credentials
  host: process.env.DB_ENDPOINT,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
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
