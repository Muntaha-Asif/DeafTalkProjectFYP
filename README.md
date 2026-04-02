
# 🧏‍♂️ DeafTalk – Sign Language Communication App

DeafTalk is a mobile application designed to enable **two-way communication between deaf/mute individuals and non-sign language users** using real-time gesture recognition and text/voice output.

---

## 📱 Features

* ✋ **Gesture Recognition**
  Detects hand gestures using camera input and converts them into meaningful text.

* 🔊 **Text-to-Speech Output**
  Converts recognized gestures into spoken words.

* ⌨️ **Text-to-Gesture Conversion**
  Converts typed or spoken input into sign language videos.

* 🌐 **Multi-language Support**
  Supports translation (e.g., Urdu → English) using LibreTranslate API.

* 🤖 **AI-Based Gesture Classifier**
  Uses a trained ML model (TFLite) to classify hand gestures.

* 👤 **User Authentication**
  Firebase Authentication (Login / Signup / Password Reset).

* 💾 **User Preferences Storage**
  Stores custom gestures and user data using Firebase Realtime Database / Hive.

---

## 🏗️ System Architecture

### 📲 Frontend (Flutter App)

* User Interface (UI)
* Gesture Capture Module (Camera + MediaPipe)
* Text/Voice Output Module

### ⚙️ Backend

* API Gateway
* AI Model (Gesture Classifier)

### 🧠 Storage

* Firebase (Authentication + Realtime Database)
* Hive (Local dataset storage)

---

## 🛠️ Technologies Used

* **Frontend:** Flutter (Dart)
* **Backend:** Python (for model training)
* **Machine Learning:** TensorFlow Lite (TFLite), MediaPipe
* **Database:** Firebase Realtime Database, Hive
* **Authentication:** Firebase Auth
* **Translation API:** LibreTranslate
* **Version Control:** Git & GitHub

---

## 📂 Project Structure

```
DeafTalk/
│
├── lib/                    # Flutter source code
│   ├── screens/            # UI screens
│   ├── widgets/            # Reusable components
│   ├── services/           # API & Firebase services
│   └── models/             # Data models
│
├── assets/
│   ├── videos/             # Gesture videos
│   └── images/             # App assets (logo, icons)
│
├── ml_model/
│   ├── model.tflite        # Trained gesture model
│   └── scaler.pkl
│
├── README.md
└── pubspec.yaml
```

---

## 🚀 Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/deaftalk.git
cd dea ftalk
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Setup Firebase

* Create a Firebase project
* Add Android/iOS app
* Download `google-services.json`
* Enable Authentication & Realtime Database

### 4️⃣ Run the App

```bash
flutter run
```

---

## 🧠 How It Works

1. The camera captures hand gestures using MediaPipe.
2. Extracted keypoints are sent to the TFLite model.
3. The model predicts the gesture label.
4. The app:

   * Displays text
   * Converts text to speech
5. For reverse communication:

   * User inputs text/voice
   * App translates (if needed)
   * Plays corresponding gesture videos

---

## 📜 License

This project is for academic purposes (FYP).
You may modify and use it with proper credit.

---

## 👨‍💻 Author

**Muntaha Asif**

* GitHub: (https://github.com/Muntaha-Asif/)
* LinkedIn: (https://www.linkedin.com/in/muntaha-asif-84156732a/)

---

## ⭐ Support

If you like this project, give it a ⭐ on GitHub!

---


* Add **badges (build, Flutter, Firebase, etc.)**
* Or make a **very attractive GitHub profile-style README (with images & icons)**
