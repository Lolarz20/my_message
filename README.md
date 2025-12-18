# MyMessage 💬

**MyMessage** is a secure, real-time messaging application built with **Flutter** and **Firebase**. Designed for speed and privacy, it provides a seamless chat experience with robust authentication, multimedia sharing, and integrated security features like passcode protection.

## 🚀 Key Features

*   **Real-Time Messaging**: Instant message delivery and synchronization using **Cloud Firestore**.
*   **Secure Authentication**: Integrated **Google Sign-In** and **Firebase Auth** for reliable user identity management.
*   **Multimedia Sharing**: Share images effortlessly with **Firebase Storage** integration.
*   **Privacy First**: Built-in **Passcode Screen** to lock the app and protect sensitive conversations.
*   **User Discovery**: Search functionality to find and connect with other users.
*   **Monetization**: Integrated **Google Mobile Ads** (AdMob) for sustainable app growth.
*   **State Management**: Efficient state handling using the **Provider** pattern.

## 🛠️ Technology Stack

*   **Frontend**: [Flutter](https://flutter.dev/) (Dart)
*   **Backend**: [Firebase](https://firebase.google.com/)
    *   Authentication
    *   Cloud Firestore
    *   Storage
    *   Analytics
*   **State Management**: `provider`
*   **Key Packages**:
    *   `firebase_auth`, `cloud_firestore`
    *   `image_picker` (Media handling)
    *   `passcode_screen` (Security)
    *   `google_mobile_ads` (Monetization)
    *   `shared_preferences` (Local storage)

## 🔧 Installation & Setup

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/my_message.git
    cd my_message
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Firebase Setup**:
    *   Ensure you have the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) placed in their respective directories (`android/app` and `ios/Runner`).

4.  **Run the app**:
    ```bash
    flutter run
    ```

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

---

*Built with ❤️ by Radek*
