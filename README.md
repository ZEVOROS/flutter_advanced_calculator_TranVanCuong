# 🏗️ ARCHITECTURE.md

## 📌 Overview
The **Advanced Calculator** project uses a clean and scalable Flutter architecture combining **MVVM + Provider** for state management. The system is divided into logical layers to improve readability, maintainability, and extensibility.

This document explains how the application is structured and how data flows between layers.

---

# 📂 1. Project Structure
```
lib/
 ├── main.dart
 ├── models/
 ├── providers/
 ├── screens/
 ├── widgets/
 ├── utils/
 └── services/
```
---

# 📁 2. Folder Responsibilities

## **models/**
Contains all data models used in the app.
Includes:
- `calculation_history.dart`
- `calculator_settings.dart`
- `calculator_mode.dart`

**Purpose:**
- Represent structured data
- Store values for expression, results, history items, settings, etc.
- No business logic inside models

---

## **providers/** (State Management)
Uses **Provider** for reactive state management.

Main providers:
- `CalculatorProvider` → handles calculations and expression updates
- `HistoryProvider` → stores, loads, and manages calculation history
- `ThemeProvider` → manages light/dark mode
- `SettingsProvider` → angle mode, precision, sound, vibration

**Responsibilities:**
- Receive UI actions
- Update internal state
- Notify UI using `notifyListeners()`

---

## **screens/**
Contains the UI screens of the application.

Includes:
- `calculator_screen.dart`
- `history_screen.dart`
- `settings_screen.dart`

**Role:**
- Display data from Providers
- Collect user input
- Navigate between modes/screens

---

## **widgets/**
Reusable UI components.

Common widgets:
- `DisplayArea`
- `CalculatorButton`
- `ButtonGrid`
- `ModeSelector`

**Role:**
- Provide modular UI
- Improve reusability and reduce duplication

---

## **utils/**
Contains helper logic and utilities.

Includes:
- `calculator_logic.dart`
- `expression_parser.dart`
- `constants.dart`

**Purpose:**
- Mathematical expression evaluation
- Operator precedence handling
- Implicit multiplication support (e.g., 2π)
- Error handling (invalid expressions/division by zero)

---

## **services/**
Handles device-related services.

Main file:
- `storage_service.dart` → interacts with SharedPreferences

**Purpose:**
- Save/load history
- Save settings (theme, angle mode, precision)
- Save calculator mode

---

# 🔄 3. Data Flow Diagram
```
      ┌──────────────┐
      │     UI       │
      └───────┬──────┘
              │ user input
              ▼
     ┌────────────────────┐
     │      Provider      │
     └───────┬────────────┘
             │ updates state
             ▼
     ┌────────────────────┐
     │   Business Logic   │
     │ (utils / services) │
     └───────┬────────────┘
             │ results / data
             ▼
      ┌──────────────┐
      │     UI       │
      └──────────────┘
```

---

# 🧠 4. Expression Engine
Mathematical expression parsing uses the `math_expressions` package but extends it with custom logic.

### Supports:
- PEMDAS rule
- Nested parentheses
- Trigonometry (DEG/RAD)
- Logarithmic and exponential operations
- Implicit multiplication: `2π`, `3(2+1)`
- Error handling with descriptive messages

---

# 🎨 5. Theme System
Managed via `ThemeProvider`.

### Features:
- Light, Dark, System mode
- Smooth transitions
- Persistent via SharedPreferences

---

# 💾 6. Persistence Layer
Using `SharedPreferences` through `storage_service.dart`.

Data stored:
- History list
- Theme mode
- Calculator mode
- Angle mode (DEG/RAD)
- Precision value
- Memory registers (M+, M-, MR)

---

# ⚙️ 7. Settings Architecture
Settings are stored in `calculator_settings.dart` and controlled via `SettingsProvider`.

Supports:
- Theme mode
- Angle mode
- Decimal precision
- Haptic feedback toggle
- Sound toggle

---

# 🧪 8. Testing Architecture
Testing includes:
- Unit tests → logic and parser
- Widget tests → buttons, display, mode selector
- Integration tests → full user flows

Test location: `/test` folder.

Target: **>80% coverage**.

---

# 🔮 9. Extensibility
The architecture allows future enhancements such as:
- Graph Mode
- Voice Input
- Export History (CSV/PDF)
- Custom Themes
- Tablet/iPad optimization

---

# ✅ Summary
This architecture ensures the calculator is:
- Scalable
- Maintainable
- Testable
- Easy to extend

It follows best practices for medium-to-large Flutter applications using Provider.