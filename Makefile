.PHONY: generate watch style test update-goldens launcher-icon splash-screen

generate:
	dart run build_runner build --delete-conflicting-outputs

watch:
	dart run build_runner watch --delete-conflicting-outputs

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
