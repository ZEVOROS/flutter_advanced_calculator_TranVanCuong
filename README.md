🧮 Advanced Calculator

A professional multi-mode Flutter calculator with scientific, programmer, history, theme, and advanced UX features.

🚀 Overview

Advanced Calculator là một ứng dụng Flutter được phát triển nhằm mô phỏng một máy tính chuyên nghiệp với đầy đủ ba chế độ:

Basic Mode

Scientific Mode

Programmer Mode

Ứng dụng được xây dựng với kiến trúc tách lớp rõ ràng, state management bằng Provider, hỗ trợ lịch sử phép tính, chế độ sáng/tối, tùy chỉnh cài đặt, và hiệu ứng animation mượt mà.

Đây là bài tập lớn thuộc Chapter 3 – Advanced Mobile Calculator.

✨ Features
🔢 Basic Mode

Các phép toán cơ bản (+, -, ×, ÷)

C, CE, %, ±

Hỗ trợ dấu ngoặc

Hiển thị biểu thức nhiều dòng

🧪 Scientific Mode

sin, cos, tan + các hàm ngược

log, ln, log₂

x², x³, xʸ, √, ∛

Hằng số π, e

n! (giai thừa)

DEG/RAD mode

Implicit multiplication (2π)

🖥️ Programmer Mode

Chuyển đổi hệ nhị phân / octal / decimal / hex

Bitwise: AND, OR, XOR, NOT

Dịch bit: <<, >>

📜 History System

Lưu tối đa 50 phép tính

Lưu qua SharedPreferences

Chạm để dùng lại phép tính

Vuốt lên để mở bảng lịch sử

🎨 Themes & UI

Light/Dark Mode

Animation chuyển chế độ

Button animation (200ms)

Responsive Layout

Material You style

⚙️ Settings

Theme: Light / Dark / System

Decimal precision: 2–10

Angle Mode: DEG/RAD

Haptic feedback

Âm thanh bấm phím

Xóa toàn bộ lịch sử

🧪 Testing

Unit test cho logic tính toán

Integration test: nhập chuỗi nút, đổi mode, lưu lịch sử

Mục tiêu coverage: >80%

🏗 Project Structure
lib/
 ├── constants.dart
 ├── main.dart
 ├── models/
 ├── providers/
 ├── screens/
 ├── widgets/
 ├── utils/
 └── services/
