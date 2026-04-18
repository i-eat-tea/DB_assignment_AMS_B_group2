// Simple session-based auth check
// In production use JWT — for school project, session token in header is fine

function requireStaff(req, res, next) {
  const token = req.headers['x-staff-token'];
  if (!token || token !== process.env.STAFF_SECRET) {
    return res.status(401).json({ error: 'Unauthorized — staff only' });
  }
  next();
}

module.exports = { requireStaff };
