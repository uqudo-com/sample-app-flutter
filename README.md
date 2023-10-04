# Uqudo SDK Flutter Demo Sample App

This project is a sample Flutter application that demonstrates the usage of the Uqudo SDK for passport onboarding with facial recognition.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- Flutter installed on your development machine
- Android Studio or VS Code with the Flutter plugin
- Knowledge of Dart programming language

## Setup and Installation

1. Clone the project from the repository.

    ```sh
    git clone https://github.com/uqudo-com/sample-app-flutter.git
    ```

2. Open the project in your preferred Flutter development environment.

3. Replace the `ACCESS_TOKEN_HERE` placeholder with the actual access token in the `_MyAppState` class inside `main.dart` file.

    ```dart
    var token = "ACCESS_TOKEN_HERE";
    ```

## Running the app

1. Use an emulator or a physical device to run the app.

2. Click on the 'Run' button in your Flutter development environment to build and run the application.

## Features

- Passport onboarding
- Facial recognition
- Handling Enrollment results

## How it works

1. The `UqudoIdPlugin.init()` method is called in the `initState()` to initialize the Uqudo SDK.

2. When the "Start Passport Onboarding" button is clicked, the `passportEnrollment()` method is invoked to begin the onboarding process.

3. The `_onEvent()` method listens to native events and prints trace events.

## Notes

- Customize the project according to your needs and refer to the [official Uqudo SDK documentation](http://docs.uqudo.com/docs/) for more details and configurations.
- Ensure that you have the necessary Uqudo SDK packages included in your `pubspec.yaml` file.
- Replace the `ACCESS_TOKEN_HERE` with your actual access token for the Uqudo SDK.
- Make sure to handle errors and edge cases as needed for your specific use case.