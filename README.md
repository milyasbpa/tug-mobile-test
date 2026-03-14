# Flutter Starter Kit

A professional Flutter Starter Kit — scalable, maintainable, and production-ready.

---

## Requirements

| Tool    | Version       |
|---------|---------------|
| Flutter | >= 3.x stable |
| Dart    | >= 3.2.5      |
| Android | minSdkVersion 21 |
| iOS     | Deployment Target 13.0 |

---

## Getting Started

### 1. Clone the repository

```bash
git clone <repo-url>
cd flutter-starter-kit
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Setup environment files

Copy the example env files and fill in the values:

```bash
cp .env.dev.example .env.dev
cp .env.staging.example .env.staging
cp .env.prod.example .env.prod
```

### 4. Run the app

```bash
# Development
flutter run --flavor dev --dart-define-from-file=.env.dev

# Staging
flutter run --flavor staging --dart-define-from-file=.env.staging

# Production
flutter run --flavor production --dart-define-from-file=.env.prod
```

Or use the Makefile shortcuts:

```bash
make run-dev
make run-staging
make run-prod
```

---

## Project Structure

```
lib/
├── core/           # Constants, DI, network, router, theme, utils
├── features/       # Feature modules (Clean Architecture)
├── shared/         # Shared widgets & models
├── app.dart        # Root widget
└── main.dart       # Entry point
```

See [FLUTTER_STARTER_KIT_TODO.md](FLUTTER_STARTER_KIT_TODO.md) for the full setup checklist.

---

## Available Scripts (Makefile)

| Command              | Description                        |
|----------------------|------------------------------------|
| `make run-dev`       | Run app in development mode        |
| `make run-staging`   | Run app in staging mode            |
| `make run-prod`      | Run app in production mode         |
| `make build-apk`     | Build release APK (production)     |
| `make build-aab`     | Build release AAB (production)     |
| `make test`          | Run all tests with coverage        |
| `make analyze`       | Run Flutter analyzer               |
| `make format`        | Format all Dart files              |
| `make gen`           | Run build_runner code generation   |

---

## Branching Strategy

```
main        ← production, protected
develop     ← integration
feature/*   ← new features
bugfix/*    ← bug fixes
hotfix/*    ← urgent production fixes
release/*   ← release preparation
```

---

## Tech Stack

- **State Management**: Riverpod / flutter_bloc
- **Navigation**: go_router
- **DI**: get_it + injectable
- **Networking**: Dio + fpdart (Either)
- **Storage**: Hive + flutter_secure_storage + shared_preferences
- **Analytics**: Firebase Analytics + Crashlytics
- **Testing**: mocktail + flutter_test

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (follow [Conventional Commits](https://www.conventionalcommits.org/))
4. Push and open a Pull Request against `develop`

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
