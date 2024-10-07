# Domi Labs Task

## Project Overview

This Domi Labs Task is a high-fidelity replication of a complex UI design, showcasing expertise in crafting intricate layouts, reusable custom widgets, animations, and state management. The app was built to demonstrate proficiency in Flutter’s advanced UI capabilities and clean architecture principles.

## Features Implemented:

- **Complex UI Design Replication:** The app faithfully reproduces the intricate UI design, showcasing the ability to recreate complex layouts and intricate designs.
- **Custom Widgets:** The app incorporates custom widgets, demonstrating the ability to create reusable and modular components.
- **Animations:** The app incorporates animations, showcasing the ability to create engaging and interactive user experiences.
- **State Management:** The app utilizes bloc for state management, demonstrating the ability to manage complex state in a scalable and maintainable way.
- **Clean Architecture:** The app follows a clean architecture, demonstrating the ability to structure code in a way that promotes maintainability, testability, and scalability.
- **Unit Tests:** The app includes unit tests, demonstrating the ability to write and maintain tests for the codebase.
- **Localization:** The app includes localization, demonstrating the ability to support multiple languages and locales.
- **Responsive Design:** The app is designed to be responsive, demonstrating the ability to create apps that work well on different screen sizes and orientations.
- **Dependency Injection:** The app uses dependency injection, demonstrating the ability to manage dependencies in a scalable and maintainable way.
- **Code Quality:** The app follows best practices for code quality, demonstrating the ability to write clean, maintainable, and testable code.
- **Documentation:** The app includes documentation, demonstrating the ability to document code and processes.
- **Theme Management:** The app includes theme management, demonstrating the ability to manage themes in a scalable and maintainable way.
- **Error Handling:** The app includes error handling, demonstrating the ability to handle errors in a scalable and maintainable way.
- **Performance Optimization:** The app includes performance optimization, demonstrating the ability to optimize code for performance.

## Setup Instructions

### Requirements:

Flutter 3.0 or above
Dart SDK

### How to Run:

1.  Clone the repository:

```bash
    git clone https://github.com/demola234/domi-labs-task.git
```

2. Navigate to the project directory:

```bash
    cd domi-id
```

3. Install dependencies:

```bash
    flutter pub get
```

4. Run the app:

```bash
    flutter run
```

## Mock Data:

The app uses mock data to simulate dynamic content. No API integration is required.

## Architecture Explanation

The app follows a clean architecture, with the following layers

- **Data Layer:** Contains the data sources, repositories, and models.
- **Domain Layer:** Contains the business logic, use cases, and entities.
- **Presentation Layer:** Contains the UI and the presentation logic.
- **Core Layer:** Contains the shared code, such as the data sources, repositories, and models.
- **Infrastructure Layer:** Contains the implementation of the data sources, repositories, and models.

## Challenges and Solutions

### Challenge 1: Complex Layout Implementation:

The app features a complex UI design with multiple nested layouts and custom widgets.
**Solution:** The app uses a combination of nested layouts and custom widgets to implement the complex layout. The app also uses a custom widget to implement the custom widget.

### Challenge 2: State Management:

The app uses bloc for state management.
**Solution:** The app uses bloc for state management. The app also uses a custom widget to implement the custom widget.

### Challenge 3: Custom Animations:

The app uses custom animations to change height of container and scroll from widget to widget.
**Solution:** The app uses a AnimatedContainer to implement the custom widget.

## Bonus Features

- **Localization**: Basic localization setup for supporting multiple languages `Chinese`, `Spanish`, `French`, `Dutch`, `English`, and `Hindi`.
- **Custom Painter**: Used `CustomPainter` for creating intricate graphic effects to match the design details.
- **Google Maps**: Used for Creating Real life Simulations of the Map.

## Folder Structure

```bash
── app
│   └── app.dart
├── bloc_observer.dart
├── bloc_provider.dart
├── core
│   ├── component
│   │   ├── filled_button.dart
│   │   └── icon_components.dart
│   ├── design_system
│   │   ├── app_colors
│   │   │   └── app_colors.dart
│   │   ├── color_extension
│   │   │   └── app_color_extension.dart
│   │   ├── font_extension
│   │   │   └── font_extension.dart
│   │   └── theme_extension
│   │       ├── app_theme_extension.dart
│   │       └── theme_detection.dart
│   ├── localization
│   │   ├── generated
│   │   │   ├── strings.dart
│   │   │   ├── strings_en.dart
│   │   │   ├── strings_es.dart
│   │   │   ├── strings_fr.dart
│   │   │   ├── strings_nl.dart
│   │   │   └── strings_zh.dart
│   │   ├── intl_en.arb
│   │   ├── intl_es.arb
│   │   ├── intl_fr.arb
│   │   ├── intl_nl.arb
│   │   ├── intl_zh.arb
│   │   ├── l10n.dart
│   │   ├── localization.dart
│   │   └── localization_detection.dart
│   └── utils
│       ├── heptic_manager
│       │   └── heptic_manager.dart
│       ├── map_style.dart
│       ├── sized_box_extension.dart
│       └── textfield_components.dart
├── feature
│   ├── data
│   │   ├── models
│   │   │   └── location_model.dart
│   │   └── repositories
│   │       └── location_repository.dart
│   ├── domain
│   │   ├── repositories
│   │   │   └── location_repository.dart
│   │   └── usecases
│   │       └── get_locations_usecase.dart
│   └── presentation
│       ├── bloc
│       │   ├── claim_address_bloc.dart
│       │   ├── claim_address_state.dart
│       │   ├── claim_address_state.freezed.dart
│       │   └── slider_cubit.dart
│       ├── view
│       │   └── claim_address_view.dart
│       └── widgets
│           ├── address_text_field_widget.dart
│           ├── claim_address_widget.dart
│           ├── custom_marker_widget.dart
│           ├── earn_with_domi_widget.dart
│           ├── google_map_widget.dart
│           ├── head_row_widget.dart
│           ├── location_suggestions.dart
│           ├── location_tile_widget.dart
│           ├── page_view_builder.dart
│           └── slider_widget.dart
├── injector.dart
└── main.dart
```

## Widget Tests:

Wrote tests for two complex widgets to verify correct rendering and behavior.

## Screenshots and Recordings

https://github.com/user-attachments/assets/906fafd9-23b2-42d3-b83d-940a5858e834



## Linting and Code Quality

- Used flutter analyze to check for any code issues and maintain code quality.
- Ensured adherence to SOLID principles and followed best practices for clean architecture.

## Conclusion

This project demonstrates the ability to handle complex Flutter UI designs, custom animations, and performance optimizations while ensuring a smooth user experience. Attention to detail was key, and the app was built with clean, scalable code that can be easily extended in the future.
