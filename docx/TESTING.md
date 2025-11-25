# 🧪 TESTING.md

## 📌 Overview
This document describes the testing strategy for the **Advanced Calculator** Flutter application, including unit tests, widget tests, and integration tests. The goal is to ensure correctness, prevent regression, and achieve **minimum 80% coverage**.

---

# ✔️ 1. Testing Types
The project includes three levels of testing:

## **1. Unit Tests**
Focuses on pure logic and functions.

Covers:
- Arithmetic operations
- Scientific functions (sin, cos, tan, log, ln, √, x², xʸ...)
- Expression parsing
- Parentheses handling
- Implicit multiplication (2π, 3(2+1))
- Error handling (divide by zero, invalid expressions)
- Memory functions (M+, M-, MR, MC)

Unit test folder:
```
test/unit/
```

Example:
```dart
test("Addition test", () {
  final logic = CalculatorLogic();
  expect(logic.evaluate("5+3"), 8);
});
```

---

## **2. Widget Tests**
Validates UI components and interaction at widget level.

Covers:
- Button rendering
- Display area updates
- Mode selector behavior
- Layout correctness across modes

Widget test folder:
```
test/widgets/
```

Example:
```dart
testWidgets('Button press updates display', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.tap(find.text('5'));
  await tester.pump();
  expect(find.text('5'), findsOneWidget);
});
```

---

## **3. Integration Tests**
Simulates full user flows.

Tests include:
- Basic → Scientific → Programmer mode switching
- History save/load
- Theme switching persistence
- Complex calculation chains
- Clearing display & history
- Settings modifications

Integration test folder:
```
test/integration/
```

Example flow:
```dart
testWidgets('Full calculation flow', (tester) async {
  await tester.pumpWidget(MyApp());

  await tester.tap(find.text('('));
  await tester.tap(find.text('5'));
  await tester.tap(find.text('+'));
  await tester.tap(find.text('3'));
  await tester.tap(find.text(')'));
  await tester.tap(find.text('×'));
  await tester.tap(find.text('2'));
  await tester.tap(find.text('='));

  expect(find.text('16'), findsOneWidget);
});
```

---

# 🎯 2. Required Test Scenarios
These scenarios **must** be included:

### **1. Basic Arithmetic**
- (5 + 3) × 2 - 4 ÷ 2 = **14**

### **2. Scientific Mode**
- sin(45°) + cos(45°) ≈ **1.414**
- log(100) = **2**
- x², xʸ, √ validations

### **3. Memory Functions**
- 5 M+ 3 M+ MR = **8**

### **4. Expression Engine**
- ((2 + 3) × (4 - 1)) ÷ 5 = **3**
- 2 × π × √9 ≈ **18.85**
- Division by 0 → error message

### **5. Programmer Mode**
- 0xFF AND 0x0F = 0x0F
- Binary/Hex switching behavior

### **6. Persistence Tests**
- Theme saved after restart
- History reloaded correctly
- Calculator mode saved

### **7. Gesture Tests**
- Swipe right deletes last character
- Swipe up opens history panel
- Long press C clears history

---

# 📊 3. Running Tests
Run all tests:
```bash
flutter test
```

Generate coverage report:
```bash
flutter test --coverage
```
Coverage file: `coverage/lcov.info`

View coverage in HTML:
```bash
genhtml coverage/lcov.info -o coverage/html
```
Then open:
```
coverage/html/index.html
```

---

# 🔧 4. Testing Tools & Packages
Uses built‑in Flutter testing tools:
- **flutter_test**
- **mockito** – mocking dependencies
- **integration_test** package for full flows

---

# 🔮 5. Testing Goal
The final goal:
- ✔ All scenarios tested
- ✔ All modes tested
- ✔ No runtime errors
- ✔ Minimum **80%+ code coverage**
- ✔ Stable across devices & orientations

---

# ✅ Summary
This testing plan ensures the calculator behaves reliably across all three modes with complex expression handling, persistent settings, and robust UI interaction. Comprehensive testing prevents regression and improves long‑term maintainability.

