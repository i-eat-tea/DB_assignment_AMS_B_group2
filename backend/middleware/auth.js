function requireStaff(req, res, next) {
  const token = req.headers['x-staff-token'];
  if (!token) {
    return res.status(401).json({ error: 'Unauthorized — staff only' });
  }
  next();
}

module.exports = { requireStaff };

