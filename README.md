# Swifty Companion

A mobile application that retrieves and displays information about 42 students using the 42 API.

## Overview

Swifty Companion is a mobile application developed using Flutter that allows users to search for and view detailed information about 42 students. The app provides a user-friendly interface to access various student data including profile information, skills, and project achievements.

## Features

### Mandatory Features
- **User Search**: Search for 42 students by their login
- **Profile Information**: Display comprehensive user details including:
  - Login
  - Email
  - Mobile
  - Level
  - Location
  - Wallet
  - Profile picture
- **Skills Display**: Show user skills with levels and percentages
- **Projects Overview**: List completed projects, including both successful and failed ones
- **Error Handling**: Comprehensive error handling for various scenarios (login not found, network errors, etc.)
- **Responsive Design**: Modern layout using flexible constraints for different screen sizes
- **Navigation**: Easy navigation between views

### Technical Requirements
- Built with Flutter framework(Dart)
- Uses the latest 42 API version
- Implements OAuth2 authentication
- Secure credential management using .env file
- Responsive UI design

### Why did I choose Flutter?

Flutter was chosen for this project for several compelling reasons:

1. **Cross-Platform Development**
   - Single codebase for both iOS and Android
   - Consistent UI and behavior across platforms
   - Reduced development and maintenance costs

2. **Performance and Efficiency**
   - Native compilation for optimal performance
   - Fast development cycle with Hot Reload
   - Rich set of pre-built widgets and components

3. **Future-Proof Technology**
   - Strong backing from Google
   - Growing community and ecosystem
   - Support for web and desktop platforms
   - Increasing demand in the job market

4. **Development Experience**
   - Clean and intuitive Dart language
   - Comprehensive documentation
   - Modern development tools and practices

While other frameworks like React Native offer similar cross-platform capabilities, Flutter's superior performance, consistent UI rendering, and growing ecosystem made it the ideal choice for this project.

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code
- 42 API credentials

### Installation
1. Clone the repository
2. Create a `.env` file with your API credentials
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Security Note
All API credentials and sensitive information are stored in a local `.env` file and are not committed to the repository.

## Project Structure
```
lib/
├── models/         # Data models and state management
├── screens/        # Main application screens
├── widgets/        # Reusable UI components
├── services/       # API services and authentication
└── utils/          # Utility functions and constants
```

## Contributing
This project is part of the 42 school curriculum. Contributions are not accepted at this time.

## License
This project is part of the 42 school curriculum and is subject to their terms and conditions.

