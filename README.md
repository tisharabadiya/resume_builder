# Resume Builder App

A simple Flutter app for building and managing resumes with the ability to add, update, delete, and reorder resume items. The app supports both mobile and web platforms.

---

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)

---

## Features
- **Resume Management**: Add, update, delete, and reorder resume items.
- **Preview Mode**: View the final resume in a preview screen.
- **Adaptive Layout**: Optimized for both smartphones and tablets.
- **Cross-Platform**: Works on mobile (Android/iOS) and web.

---

## Tech Stack
- **Flutter**: 3.29.3
- **State Management**: Provider
- **Data Storage**: SharedPreferences
- **UI Framework**: Material Design

---

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- VS Code 
- Emulator or physical device for testing

### Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/tisharabadiya/resume_builder.git

2. **Install Dependencies**:  
    flutter pub get 

3. **Run on device or emulator**:
    flutter run

4. **Build APK (for Android)**:
    flutter build apk --release

    The generated APK will be in:
      build/app/outputs/flutter-apk/app-release.apk
