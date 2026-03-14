.PHONY: help \
        run-dev run-staging run-prod \
        build-apk-dev build-apk-staging build-apk build-apk-prod \
        build-aab build-ipa \
        build-ios-dev build-ios-staging \
        test test-watch coverage analyze format format-fix gen gen-watch clean outdated upgrade

# ─── Help ───────────────────────────────────────────────────────────────────────

help:
	@echo ""
	@echo "  Flutter Starter Kit — available targets"
	@echo ""
	@echo "  Run:"
	@echo "    make run-dev           flutter run (dev flavor + .env.dev)"
	@echo "    make run-staging       flutter run (staging flavor + .env.staging)"
	@echo "    make run-prod          flutter run (production flavor + .env.prod)"
	@echo ""
	@echo "  Build Android:"
	@echo "    make build-apk-dev     APK (dev flavor)"
	@echo "    make build-apk-staging APK (staging flavor)"
	@echo "    make build-apk-prod    APK (production, obfuscated)"
	@echo "    make build-aab         AAB for Play Store (production)"
	@echo ""
	@echo "  Build iOS:"
	@echo "    make build-ios-dev     .app (dev flavor, no codesign)"
	@echo "    make build-ios-staging .app (staging flavor, no codesign)"
	@echo "    make build-ipa         IPA for App Store (production)"
	@echo ""
	@echo "  Quality:"
	@echo "    make analyze           flutter analyze"
	@echo "    make format            dart format (exit if changed)"
	@echo "    make format-fix        dart format (fix in place)"
	@echo "    make test              flutter test --coverage"
	@echo "    make coverage          test + generate HTML coverage report"
	@echo ""
	@echo "  Code generation:"
	@echo "    make gen               build_runner build"
	@echo "    make gen-watch         build_runner watch"
	@echo ""
	@echo "  Utilities:"
	@echo "    make clean             flutter clean + pub get"
	@echo "    make outdated          flutter pub outdated"
	@echo "    make upgrade           flutter pub upgrade --major-versions"
	@echo ""

# ─── Run ────────────────────────────────────────────────────────────────────────

run-dev:
	flutter run --flavor dev --dart-define-from-file=.env.dev

run-staging:
	flutter run --flavor staging --dart-define-from-file=.env.staging

run-prod:
	flutter run --flavor production --dart-define-from-file=.env.prod

# ─── Build Android ──────────────────────────────────────────────────────────────

build-apk-dev:
	flutter build apk --flavor dev --dart-define-from-file=.env.dev

build-apk-staging:
	flutter build apk --flavor staging --dart-define-from-file=.env.staging

# Alias: build-apk and build-apk-prod both build the production APK (obfuscated)
build-apk-prod:
	flutter build apk --flavor production --dart-define-from-file=.env.prod --obfuscate --split-debug-info=build/debug-info

build-apk: build-apk-prod

build-aab:
	flutter build appbundle --flavor production --dart-define-from-file=.env.prod --obfuscate --split-debug-info=build/debug-info

# ─── Build iOS ──────────────────────────────────────────────────────────────────

build-ios-dev:
	flutter build ios --flavor dev --dart-define-from-file=.env.dev --no-codesign

build-ios-staging:
	flutter build ios --flavor staging --dart-define-from-file=.env.staging --no-codesign

build-ipa:
	flutter build ipa --flavor production --dart-define-from-file=.env.prod --obfuscate --split-debug-info=build/debug-info

# ─── Code Quality ───────────────────────────────────────────────────────────────

analyze:
	flutter analyze

format:
	dart format --set-exit-if-changed lib/ test/

format-fix:
	dart format lib/ test/

# ─── Testing ────────────────────────────────────────────────────────────────────

test:
	flutter test --coverage

test-watch:
	flutter test --coverage --reporter expanded

coverage:
	flutter test --coverage && genhtml coverage/lcov.info -o coverage/html && open coverage/html/index.html

# ─── Code Generation ────────────────────────────────────────────────────────────

gen:
	dart run build_runner build --delete-conflicting-outputs

gen-watch:
	dart run build_runner watch --delete-conflicting-outputs

# ─── Utilities ──────────────────────────────────────────────────────────────────

clean:
	flutter clean && flutter pub get

outdated:
	flutter pub outdated

upgrade:
	flutter pub upgrade --major-versions
