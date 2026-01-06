# AI Coding Assistant

An intelligent Flutter application that provides AI-powered coding assistance for multiple programming languages using Google's Gemini API.

![AI Coding Assistant](https://i.imgur.com/YGLvZpU.png)

## Features

- **Ask Coding Questions**: Get detailed answers to any coding question based on your selected programming language
- **Debug Code**: Identify bugs and issues in your code with AI-powered analysis
- **Explain Code**: Get comprehensive explanations of how your code works
- **Improve Code**: Receive suggestions for optimizing and enhancing your code
- **Multiple Language Support**: Works with Python, JavaScript, Java, C++, and many other languages
- **Beautiful UI**: Dark theme with syntax highlighting and professional animations
- **Markdown Rendering**: Format code blocks and text with proper markdown styling

## Technology Stack

- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Google Gemini API**: AI language model for generating responses
- **HTTP Package**: For API communication
- **Flutter Markdown**: For rendering formatted responses

## Setup Instructions

### Prerequisites

- Flutter SDK installed
- Google Gemini API key

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/code_assistant.git
   cd code_assistant
   ```

2. Install dependencies
   ```
   flutter pub get
   ```

3. Set up your Gemini API key
   - Get an API key from [Google AI Studio](https://ai.google.dev/)
   - Open `lib/utils/constants.dart`
   - Replace the placeholder API key with your own:
     ```dart
     class ApiConstants {
       static const String apiKey = 'YOUR_API_KEY_HERE';
       static const String modelName = 'gemini-1.5-pro';
     }
     ```

4. Run the app
   ```
   flutter run
   ```

## Usage Guide

### Ask Coding Questions

1. Select your programming language from the dropdown
2. Type your coding question in the text field
3. Tap "Get Answer"
4. View the response with proper markdown formatting

### Debug Code

1. Select your programming language
2. Enter or paste your code in the editor
3. Tap "Debug Code"
4. Review the identified issues and suggested fixes

### Explain Code

1. Select your programming language
2. Enter or paste your code in the editor
3. Tap "Explain Code"
4. Get a detailed breakdown of how your code works

### Improve Code

1. Select your programming language
2. Enter or paste your code in the editor
3. Tap "Improve Code"
4. Review suggestions for code optimization and improvements

## UI Features

- **Custom Loading Animations**: Unique loading animations for each feature
- **Language-specific Feedback**: AI responses tailored to the selected language
- **Markdown Support**: Code blocks, bold text, and other formatting
- **Responsive Design**: Works on different screen sizes and orientations
- **Syntax Highlighting**: Clear code formatting in responses

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- Google Gemini for providing the AI capabilities
- Flutter team for the amazing framework
- All contributors who have helped improve this project
