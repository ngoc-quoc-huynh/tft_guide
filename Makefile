.PHONY: generate watch check-code check-files style test update-goldens launcher-icon splash-screen check-code check-files

generate:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

check-code:
	dart run dart_code_metrics:metrics check-unused-code lib --disable-sunset-warning

check-files:
	dart run dart_code_metrics:metrics check-unused-files lib --disable-sunset-warning

style:
	dart format lib
	flutter analyze
	dart run dart_code_metrics:metrics analyze . --set-exit-on-violation-level=warning --disable-sunset-warning

test:
	flutter test --coverage --test-randomize-ordering-seed=random
	dart run test_cov_console --exclude=static

update-goldens:
	flutter test --update-goldens --tags=golden

launcher-icon:
	dart run flutter_launcher_icons --file launcher_icon.yaml

splash-screen:
	dart run flutter_native_splash:create --path=splash_screen.yaml

check-code:
	dart run dart_code_metrics:metrics check-unused-code lib --disable-sunset-warning

check-files:
	dart run dart_code_metrics:metrics check-unused-files lib --disable-sunset-warning
