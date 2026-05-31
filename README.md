# 🏨 Grand Phrovilla — Hotel Management System

> Database Assignment · Group 2 · AMS-B · Institute of Technology of Cambodia

A full-stack hotel management system with a customer web portal and a staff management dashboard, connected to a live MySQL database.

---

## ⚡ Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Vanilla HTML · CSS · JavaScript |
| Backend | Node.js · Express |
| Database | MySQL |
| Hosting | Render (backend) · Railway (MySQL) |

---

## 📁 Folder Structure

```
DB-assignment-group2-AMS-B/
├── backend/
│   ├── server.js              ← Express entry point
│   ├── db.js                  ← MySQL connection pool
│   ├── routes/
│   │   ├── auth.js            ← Login for customer & staff
│   │   ├── customer.js        ← Customer-facing endpoints
│   │   └── staff.js           ← Staff-facing endpoints
│   └── middleware/
│       └── auth.js            ← Staff route protection
├── frontend/
│   ├── customer/              ← Customer website
│   └── staff/                 ← Staff dashboard
├── db/
│   ├── schema.sql             ← Database schema
│   └── insert_data.sql        ← Dummy data for testing
├── .env.example               ← Copy to .env and fill in
└── package.json
```

---

## 🚀 Setup

### 1. Clone & Install
```bash
git clone https://github.com/i-eat-tea/DB-assignment-group2-AMS-B
cd DB-assignment-group2-AMS-B
npm install
```

### 2. Configure Environment
```bash
cp .env.example .env
```
Then open `.env` and fill in your database credentials:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=mydb
DB_PORT=3306
STAFF_SECRET=any_random_string
PORT=3000
```

### 3. Run Locally
```bash
npm run dev
```
Then open your browser:
- 👤 Customer portal → `https://db-assignment-ams-b-group2.onrender.com/customer`
- 🔧 Staff dashboard → `https://db-assignment-ams-b-group2.onrender.com/staff`

### 4. Deploy to Render
1. Push repo to GitHub
2. Connect repo to [Render](https://render.com)
3. Set environment variables in Render dashboard (same as `.env`)
4. Set start command to `node backend/server.js`

---

## 🔌 API Endpoints

### 🔐 Auth
| Method | Endpoint |
|--------|----------|
| `POST` | `/api/auth/customer/login` |
| `POST` | `/api/auth/customer/register` |
| `POST` | `/api/auth/staff/login` |

### 👤 Customer
| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/customer/rooms/available` | Check available rooms by date |
| `POST` | `/api/customer/reservation` | Make a reservation |
| `PUT` | `/api/customer/reservation/:id/cancel` | Cancel a reservation |
| `GET` | `/api/customer/reservations/:customer_id` | View booking history |
| `GET` | `/api/customer/receipt/:reservation_id` | View receipt |
| `POST` | `/api/customer/review` | Submit a review |
| `GET` | `/api/customer/promotionals` | Get active promotions |

### 🔧 Staff
> All staff endpoints require `x-staff-token` header

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/staff/reservations` | View all reservations |
| `PUT` | `/api/staff/reservation/:id/confirm` | Confirm reservation |
| `PUT` | `/api/staff/reservation/:id/cancel` | Cancel reservation |
| `POST` | `/api/staff/checkin/:reservation_id` | Check in customer |
| `PUT` | `/api/staff/checkout/:reservation_id` | Check out + generate bill |
| `POST` | `/api/staff/room` | Add new room |
| `PUT` | `/api/staff/room/:id` | Edit room |
| `PUT` | `/api/staff/room/:id/conditions` | Update room status |
| `GET` | `/api/staff/staff` | View all staff |
| `POST` | `/api/staff/staff` | Add new staff |
| `PUT` | `/api/staff/staff/:id` | Edit staff |
| `PUT` | `/api/staff/staff/:id/penalty` | Add penalty points |
| `PUT` | `/api/staff/customer/:id/blacklist` | Blacklist a customer |
| `POST` | `/api/staff/promotional` | Create promotion |
| `PUT` | `/api/staff/promotional/:id` | Edit promotion |
| `GET` | `/api/staff/reports/occupancy` | Occupancy report |
| `GET` | `/api/staff/reports/revenue` | Revenue report |
| `GET` | `/api/staff/reports/stats` | Descriptive stats |

---


