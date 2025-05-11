# AD Secure Courier Platform

## 📦 Overview
A secure multi-role logistics and courier platform supporting admins, users, and delivery riders. This project integrates web, mobile, and backend systems to offer real-time parcel management, strong authentication, and security-focused architecture.

## 🧑‍💻 Project Roles
- **Admins**: Manage users, track parcels, set commissions.
- **Users**: Register, send, and track packages.
- **Riders**: Accept delivery tasks and update delivery status via mobile.

## 🔐 Security Features
- ✅ Password Hashing (bcrypt)
- ✅ CSRF Token Protection
- ✅ XSS Input Sanitization
- ✅ SQL Injection Protection (Prepared Statements)
- ✅ Two-Factor Authentication (Google Authenticator)

## 🛠 Technologies Used
- **Frontend**: React.js (user web), Flutter (mobile app)
- **Backend**: Node.js + Express.js
- **Database**: MySQL
- **Mobile Tools**: Android Studio, Firebase
- **Version Control**: Git + GitHub

## 📂 Project Structure
```
adcourier_admin       → Admin web dashboard
adcourier_user_web    → User-facing web platform
adcourier_rider       → Rider mobile app (Flutter)
```

## ✅ Setup Instructions
1. Clone the repo:
   ```bash
   git clone https://github.com/Adonay14/AD-secure-courier-platform.git
   ```
2. Navigate into any folder and follow its README/setup (if included).

## 🧪 Testing Strategy
- Unit & manual testing across modules
- Manual security checks (CSRF, XSS, SQLi)
- Real device tests for the mobile app

## 📃 License
This project is for academic and learning use. Feel free to fork and explore.

---

_Developed by Adonay Mustofa — BSc Cybersecurity, National College of Ireland_
