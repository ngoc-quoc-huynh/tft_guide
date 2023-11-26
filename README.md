# tft_guide

Source code for the TFT Guide Flutter app.

## Prerequisites

### Flutter setup

- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Update your `PATH` variable to the location of the SDK
- Make sure flutter is on the stable channel: `flutter channel stable`
- Check whether your system is properly set up: `flutter doctor`

### Android setup

- Install the [Android SDK](https://developer.android.com/studio)
- Set environment variable `ANDROID_HOME` to the location of the SDK

### iOS setup

- Be a Mac OS user
- Install XCode
    - You'll need to be logged in with an Apple Developer account to download XCode
- Start XCode once and follow the instructions

## Code generation

A few parts of the app rely on automatic code generation. Full code generation can be executed at
once using [`build_runner`](#build_runner).

### build_runner

Most code generation plugins use the standard Dart build framework and can be invoked using:

```sh
make generate
```

To continuously rebuild whenever relevant files change (recommended), use:

```sh
make watch
```

## Code style

In our project, we follow a consistent code style to ensure readability, maintainability, and
collaboration among team members. Adhering to a unified code style not only improves code quality
but also enhances the overall development process.

To ensure adherence to our code style guidelines, we have developed custom lint rules and
metrics ([cosee_lints](https://pub.dev/packages/cosee_lints)).

To format and analyze the codebase, you can run the following command:

```sh
make style
```

## Tests

To execute the tests, run the following command in your terminal:

```sh
make test
```

### Golden tests

We utilize Golden Tests for our UI testing process. These tests are specifically designed to verify
the visual output of our application and guarantee consistent appearance across UI components, thus
mitigating any potential UI regression issues.

The golden files for our UI tests are located in the `test/ui/**/goldens` directory.

To update these golden files, simply execute the following command:

```sh
make update-goldens
```

This will update all golden files, so be careful when running this command to ensure that all
changes to the UI are intentional.

## Git hooks

We use [lefthook](https://github.com/evilmartians/lefthook) to run all coding convention checks as
git pre-commit/pre-push hook.

### Installation

To install lefthook run the following command:

```sh
brew install lefthook
```

### Usage

To initialize lefthook run the following command:

```sh
lefthook install
```

This will set up git pre-commit/pre-push hooks containing checks as configured
in [`lefthook.yaml`](lefthook.yaml).

# https://www.metatft.com/items

## TFT Items

The items are taken from [`metatft`](https://www.metatft.com/items)
and [`tftactics`](https://tftactics.gg/item-builder).