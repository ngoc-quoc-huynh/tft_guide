.PHONY: i18n check-i18n check-code style test update-goldens launcher-icon splash-screen check-code check-files apk

i18n:
	dart run slang

check-i18n:
	dart run slang analyze

check-code:
	dart run dart_code_linter:metrics check-unused-code lib

check-files:
	dart run dart_code_linter:metrics check-unused-files lib

style:
	dart format .
	flutter analyze
	dart run dart_code_linter:metrics analyze . --set-exit-on-violation-level=warning

test:
	flutter test --coverage --test-randomize-ordering-seed=random --dart-define=CI=true
	dart run test_cov_console --exclude=static

update-goldens:
	flutter test test/ui/ --update-goldens --tags=golden

splash-screen:
	dart run flutter_native_splash:create --path=splash_screen.yaml

apk:
	flutter build apk \
		--release \
		--obfuscate \
		--split-debug-info=./build/app/outputs/symbols \
		--dart-define-from-file=.env.json
