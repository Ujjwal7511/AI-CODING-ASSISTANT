# AI Code Assistant

An intelligent mobile coding companion built with **Flutter (Dart)** and powered by **Gemini API** to help developers write, understand, and debug code faster.

---

## Overview

AI Code Assistant is a mobile application designed to assist developers in real time. It leverages generative AI to provide code suggestions, explanations, debugging help, and learning support — all within a clean and responsive Flutter interface.

This project demonstrates the integration of AI APIs with mobile app development to create a productivity-focused developer tool.

---

## Key Features

* 💡 Code generation for multiple programming languages
* 🧠 Code explanation in simple, beginner‑friendly language
* 🐞 Debugging assistance and error suggestions
* 📚 Learning support for concepts and syntax
* 📱 Clean and responsive mobile UI built using Flutter
* ⚡ Fast AI responses via Gemini API integration

---

## Tech Stack

**Frontend:**

* Flutter
* Dart

**Backend / AI Integration:**

* Gemini API

**Tools & Environment:**

* Android Studio / VS Code
* Git & GitHub

---

## App Architecture

The application follows a modular structure:

1. **UI Layer** – Flutter widgets for user interaction
2. **Service Layer** – Handles API calls and response processing
3. **AI Integration Layer** – Gemini API for generating intelligent outputs
4. **State Management** – Manages user input, responses, and app flow

---

## How It Works

1. User enters a coding query or problem
2. App sends request to Gemini API
3. AI processes the prompt and generates a response
4. Response is formatted and displayed in the app
5. User can refine queries for better results

---

## Installation & Setup

### Prerequisites

* Flutter SDK installed
* Dart installed
* Android Studio or VS Code
* Gemini API key

### Steps

```bash
# Clone the repository
git clone https://github.com/your-username/ai-code-assistant.git

# Navigate to project folder
cd ai-code-assistant

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## Configuration

Add your Gemini API key in the configuration file:

```
lib/config/api_config.dart
```

Example:

```dart
const GEMINI_API_KEY = "YOUR_API_KEY_HERE";
```

---

## Use Cases

* Students learning programming
* Developers needing quick code help
* Debugging support on the go
* Interview preparation
* Understanding complex code snippet

---

## Future Enhancements

* Voice‑based coding assistance
* Multi‑file code understanding
* GitHub integration
* Dark/Light AI‑optimized themes
* Offline knowledge caching
* Code execution sandbox

---

## Challenges Faced

* Optimizing API response time
* Formatting AI responses for mobile readability
* Managing state during long prompts
* Handling different programming languages

---

## Learning Outcomes

* AI + mobile app integration
* API handling in Flutter
* Prompt engineering fundamentals
* UI/UX design for developer tools

---

## Contribution

Contributions are welcome! Feel free to fork the repo and submit pull requests.

---

## Author

**Ujjwal Kumar Singh**
Aspiring software developer passionate about AI, mobile apps, and developer tools.
