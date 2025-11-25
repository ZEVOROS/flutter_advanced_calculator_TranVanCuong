Dưới đây là một file **README.md** được viết lại dành cho project Flutter Calculator của bạn, trình bày rõ ràng, dễ đọc và có đầy đủ hướng dẫn cơ bản:

````markdown
# Flutter Calculator App

A simple and responsive calculator app built with **Flutter**. This app supports basic arithmetic operations, percentage, change sign, and a history display for past calculations.

---

## Features

- Basic arithmetic operations: **Addition (+), Subtraction (-), Multiplication (×), Division (÷)**
- Percentage calculation (%)
- Change sign (±)
- Clear display (`C`) and delete last character (`CE`)
- Continuous calculations without resetting
- Calculation history display
- Responsive UI that scales to different screen sizes
- Error handling for invalid operations (e.g., division by zero)

---

## Screenshots

| Calculator Display | Button Panel |
|-------------------|--------------|
| ![Calculator Display](screenshots/display.png) | ![Button Panel](screenshots/buttons.png) |

*Note: Add your own screenshots in the `screenshots` folder.*

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0
- Dart >= 3.0
- Android Studio or VS Code (recommended)
- Device or emulator to run the app

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/flutter_calculator.git
cd flutter_calculator
````

2. Get dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

---

## Usage

* Tap numeric buttons to input numbers.
* Tap operation buttons (`+`, `-`, `×`, `÷`) to perform calculations.
* Tap `=` to get the result.
* Use `C` to clear all, `CE` to delete the last input.
* Tap `±` to change the sign of the current number.
* Tap `%` to convert the current number to a percentage.
* Past calculations are displayed in the history section.

---
