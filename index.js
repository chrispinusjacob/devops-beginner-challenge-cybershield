require('dotenv').config();

const express = require('express');
const app = express();
const port = process.env.PORT || 5000;

app.get('/', (req, res) => {
  res.send('Hello, DevOps! Updated'); // Changed text for testing
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
