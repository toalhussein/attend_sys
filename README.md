# Employee Attendance System

[![Dart](https://img.shields.io/badge/Dart-93.9%25-blue)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%26%20Auth-yellow)](https://firebase.google.com/)
[![Platform](https://img.shields.io/badge/Cross--Platform-Flutter-blueviolet)](https://flutter.dev/)

## 📋 Overview

**Employee Attendance System** is a modern, cross-platform application built with Flutter. The system is designed to efficiently handle employee attendance tracking by leveraging Firebase Firestore and Firebase Authentication. Employees mark their attendance using their unique Employee ID, and the system captures their GPS location for secure and accurate check-ins. 

Admins can manage employees, monitor attendance data in real-time, and view the exact location of attendance events on Google Maps.

---

## ✨ Features

- **Employee Authentication:** Secure login using Employee ID integrated with Firebase Auth.
- **GPS Attendance Capture:** Employees mark attendance, and their location is recorded using device GPS.
- **Firestore Database:** All attendance data is stored and managed with Firebase Firestore.
- **Admin Dashboard:**
  - Add, edit, and delete employee records.
  - Monitor employee attendance logs.
  - View attendance locations on Google Maps.
  - Track from where each employee logged in.
- **Real-Time Monitoring:** Instant updates for attendance and employee management.
- **Cross-Platform:** Built with Flutter, supporting Android and iOS devices.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Firebase Project (Firestore & Auth enabled)
- Google Maps API Key

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/toalhussein/attend_sys.git
   cd attend_sys
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS) files to the respective directories.
   - Make sure Firestore and Authentication are enabled in your Firebase console.

4. **Set up Google Maps:**
   - Add your Google Maps API key to the project as per the [Flutter Google Maps documentation](https://pub.dev/packages/google_maps_flutter).

5. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase Firestore, Firebase Auth
- **Location:** GPS via device sensors
- **Maps Integration:** Google Maps API
- **Native Integrations:** Swift, CMake, C++, Shell scripts

---

## 📂 Project Structure

```
attend_sys/
├── lib/           # Dart source code (UI & logic)
├── android/       # Android-specific code & config
├── ios/           # iOS-specific code & config
├── assets/        # Images, icons, etc.
├── scripts/       # Shell and CMake scripts
├── pubspec.yaml   # Flutter dependencies
```

---

## 👤 Admin Features

- **Employee Management:** Add, edit, and delete employees.
- **Attendance Monitoring:** View logs and statistics.
- **Location Tracking:** Visualize check-in/out locations on Google Maps.
- **Audit Logs:** Track when and from where employees access the system.

---

## 🙋‍♂️ Employee Features

- **Secure Login:** Authenticate with Employee ID.
- **Easy Check-In/Out:** Mark attendance with a single tap.
- **Location Verification:** Attendance is only accepted if GPS is enabled and from a specified range of longtiude and latitude.

---

## 🤝 Contributing

Contributions are welcome! Please fork the repository and create a pull request.

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

> **If you find this project helpful, please star the repository!**
