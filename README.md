# Comic Vine App

A Flutter application that fetches comic book data from the Comic Vine API and displays a list of comic books with detailed information about each comic. The app includes features like data pagination, caching, forced data refresh, and the ability to view comic details both from API data and locally cached data.

## Version Implemented

This is the **V4** implementation of the app, which includes the following features:

- Full UI implementation for comic list and comic details views.
- Data retrieved from the Comic Vine API.
- State management using **Flutter Bloc**.
- Pagination on the list view.
- Caching of comic details for offline access.
- Forced refresh of comic details using a **RefreshIndicator**.
- Local data storage using **SQLite** for caching comic details.

## Architecture

The app follows the principles of **Clean Architecture** and is structured into distinct layers:

- **Presentation Layer**: Contains all the UI components, including widgets for the comic list and comic details.
    - State management is handled by **Flutter Bloc** for managing the business logic and UI updates.

- **Domain Layer**: Defines the core business logic, such as entities and repositories, independent of any external dependencies.

- **Data Layer**: Responsible for handling the data sources such as the Comic Vine API and local SQLite database.
    - API calls are managed using the `http` package, and local storage is handled with the `sqflite` package.

## Features

- **Comic List**: Fetches a paginated list of comics from the Comic Vine API and displays it to the user. Users can scroll through the list to load more comics.
- **Comic Details**: Displays detailed information about a selected comic, including creators, characters, teams, and more.
- **Caching**: Comic details are cached locally using SQLite, so users can view them offline.
- **Forced Refresh**: Users can pull to refresh the comic details to get the latest data from the API.

## Screenshots

### Comic List
![image](https://github.com/user-attachments/assets/184e626a-7078-4180-93bd-2cbbb1b26403)
![image](https://github.com/user-attachments/assets/2c763aa6-35c3-45d0-8989-a15fa9ada859)

### Comic Details

![image](https://github.com/user-attachments/assets/1a006296-f32e-47b4-82a0-31790b509358)
![image](https://github.com/user-attachments/assets/a92fe72c-142e-46ae-8027-e99619afa19f)



## How to Set Up and Run the Project

### Prerequisites

Before setting up the project, ensure you have the following installed:

- **Flutter SDK** (version 3.24.0 or higher)
- **Android Studio** or **Xcode** (for iOS)
- A device/emulator to run the app

### Installation Steps

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/uverdiazla/comic_vine_app.git
   cd comic_vine_app

2. **Install Flutter Dependencies:** 

   Make sure you have Flutter 3.24.0 installed. You can check your Flutter version with:

        flutter --version
   
   Before proceeding, verify that your environment is correctly set up with the necessary dependencies by running:

       flutter doctor

   Ensure that there are no errors in the output. If any issues are highlighted, resolve them before continuing. Once flutter doctor gives you a clean bill of health, install the project dependencies by running:

       flutter pub get

4. **Set up the API Key:**

   The app requires a Comic Vine API key to function. Add your API key to the lib/core/config/app_config.dart file:

   ```dart
   class AppConfig implements IAppConfig {
    final String baseUrl = 'https://comicvine.gamespot.com/api';
    final String apiKey = 'YOUR_API_KEY_HERE';  // Add your API key here
    }
5. **Run the App:**

   Connect a device/emulator and run the app using the following command:

       flutter run

   Make sure your device/emulator is connected and detected by Flutter:

        flutter devices

### Running the Tests:

Unit and Widget Tests
Unit and widget tests are located in the test/ directory. To run all unit and widget tests, use:

    flutter test

Integration Tests
The integration tests ensure the app's functionality across multiple screens and flows. You can run them on a real device or emulator.

Make sure you have a connected device or emulator running:

    flutter devices

Run the integration tests with:

    
    flutter test integration_test/app_flow_test.dart

#### Notes for Integration Testing

- Integration tests simulate user interaction with the app, including navigation and data loading.
- The tests use real API data and cache interactions (no mock data).
- Ensure that the API is accessible and there is an active internet connection when running integration tests.

## Project Dependencies

The app uses the following dependencies:

- **Flutter Bloc**: State management solution.
- **HTTP**: To make API calls.
- **Sqflite**: Local SQLite database storage for caching.
- **XML**: Parsing XML responses from the Comic Vine API.
- **GetIt**: Dependency injection.
- **path_provider**: For accessing the device's file system.
- **flutter_test**: For writing and running unit tests.
- **integration_test**: For writing and running integration tests.

## Author

- **Uver Diaz**
