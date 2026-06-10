# centernews

Flutter News App

## Getting Started

How to install?
1. Clone this repo.
2. Install flutter [Install with VSCode
](https://docs.flutter.dev/install/with-vs-code) or [install manually](https://docs.flutter.dev/install/manual)
3. Run this in terminal 'flutter pub get' to install dependencies.
4. Plug in your mobile device to your computer. Make sure to turn on Developer mode and USB Debugging
5. Run this in terminal, environment specific:
- **DEV**
  ```bash
  flutter run --flavor dev --dart-define=FLAVOR=dev
  ```
- **QAT**
  ```bash
  flutter run --flavor qat --dart-define=FLAVOR=qat
  ```
- **UAT**
  ```bash
  flutter run --flavor uat --dart-define=FLAVOR=uat
  ```
- **PROD**
  ```bash
  flutter run --flavor prod --dart-define=FLAVOR=prod
  ```

