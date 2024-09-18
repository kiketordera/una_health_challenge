# Blood Glucose App

## How to Run

1. Clone the repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to start the app.

## Features

- Displays blood glucose levels over time.
- Filters data based on selected dates.
- Shows minimum, maximum, average, and median values.
- Plots average and median lines on the chart.

## Project Structure

The project follows the Clean Architecture pattern, separating concerns into different layers:

- **Presentation Layer**: UI code and widgets.
- **Domain Layer**: Business logic, entities, and use cases.
- **Data Layer**: Data models, data sources, and repository implementations.