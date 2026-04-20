const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

// Serve frontend static files
app.use('/customer', express.static(path.join(__dirname, '../frontend/customer')));
app.use('/staff', express.static(path.join(__dirname, '../frontend/staff')));

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/customer', require('./routes/customer'));
app.use('/api/staff', require('./routes/staff'));

// Health check
app.get('/', (req, res) => res.json({ message: 'Hotel AMS-B API running' }));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));