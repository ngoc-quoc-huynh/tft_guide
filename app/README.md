# App

[![build status](https://github.com/ngoc-quoc-huynh/tft_guide/actions/workflows/app.yaml/badge.svg?branch=main)](https://github.com/ngoc-quoc-huynh/tft_guide/actions/workflows/app.yaml?query=branch%3Amain)
[![style](https://img.shields.io/badge/style-cosee__lints-brightgreen)](https://pub.dev/packages/cosee_lints)
[![release](https://img.shields.io/github/v/release/ngoc-quoc-huynh/tft_guide)](https://github.com/ngoc-quoc-huynh/tft_guide/releases/latest)
[![license](https://img.shields.io/github/license/ngoc-quoc-huynh/tft_guide)](https://raw.githubusercontent.com/ngoc-quoc-huynh/tft_guide/refs/heads/main/LICENSE)

## Overview

This repository contains the source code for the TFT Guide flutter app.
The app uses [supabase](https://supabase.com/) to load and sync remote data with a
local [SQLite](https://pub.dev/packages/sqlite_async) database. This allows for seamless data
access, even in offline scenarios, ensuring the user experience remains smooth and uninterrupted.

## Getting Started

### asdf

We are using [asdf](https://asdf-vm.com/) to manage the dependencies. Make sure you have it
installed and then run the following command to install the required versions:

```bash
asdf install
```

If you don't have asdf installed or prefer not to use it, you can
install [Flutter](https://docs.flutter.dev/) directly by following the
official[Flutter installation guide](https://docs.flutter.dev/get-started/install). Make sure to use
the version specified in the [.tool-versions ](../.tool-versions) file to avoid compatibility
issues.

### Local Development

The project uses environment variables for configuration. Follow the steps below to set up the local
environment:

1. Create an `env.json` file in the project root directory. Use the
   [`env.example.json`](.env.example.json) file as a template:

   ```bash
   cp .env.example.json .env.json
   ```

2. Populate the `env.json` file with the required values:

   Open `env.json` and fill in the `supabase_url`, `supabase_anon_key`, `github_owner`, and
   `github_repo` fields using the information from your GitHub and supabase project:

    - **supabase_url**: Available in your Supabase project settings under
      **Project Settings > API**.
    - **supabase_anon_key**: Available in the same **API** section.
    - **github_owner**: The owner of the GitHub repository.
    - **github_repo**: The name of the GitHub repository.

3. Run the app:

   Use the following command to start the application with the environment variables loaded from
   `env.json`:

   ```bash
   flutter run --dart-define-from-file=.env.json
   ```

### Code generation for translations

We are using [slang](https://pub.dev/packages/slang) to manage the translations.

Run the following command to generate the translations:

```bash
make i18n
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

### Code style enforcement with lefthook

To automatically format staged code before committing, we
use [lefthook](https://github.com/evilmartians/lefthook) as a pre-commit hook.
Our configuration ensures that only staged Dart files in the app directory are formatted with dart
format.

```sh
lefthook install
```

## Create a release APK

To generate a release APK for your application, follow the steps below:

1. Create a `key.properties` file in the android root directory. Use the
   [`key.example.properties`](android/key.example.properties) file as a template:

   ```sh
   cp android/key.example.properties android/key.properties
   ```

2. Create a `keystore` file:
    - **Option 1**: Using Android Studio

      You can generate a keystore directly from Android Studio by following
      the [official guide](https://developer.android.com/studio/publish/app-signing#generate-key).
    - **Option 2**: Using the Command Line

      Alternatively, use the `keytool` command to generate a keystore:
       ```sh
       keytool -genkey -v -keystore android/app/tft_guide.jks -keyalg RSA -keysize 2048 -validity 10000 -alias tft_guide
       ```
3. Set up secrets in GitHub (optional, for GitHub Actions):

   Next, you need to set up the following secrets in your GitHub repository:

    - **KEY_PASSWORD**: The password for the key.
    - **STORE_PASSWORD**: The password for the keystore.
    - **KEY_ALIAS**: The alias of the key, by default it is `tft_guide`.
    - **KEYSTORE**: The base64-encoded version of your keystore file.

### Encoding the keystore file

1. Run the following command to encode your `tft_guide.jks` file:

   ```sh
   base64 -i android/app/tft_guide.jks -w 0 > android/app/tft_guide_base64
   ```

2. Copy the content of [tft_guide_base64](android/app/tft_guide_base64), and then paste it into the
   `KEYSTORE` secret on GitHub.

### Generate the release APK

Once your `keystore` and `key.properties` are set up, you can generate the release APK by running
the following command:

```sh
make apk
```

## Tests

To execute the tests, run the following command in your terminal:

```sh
make test
```

This will run the test in random order.
If you want to specify a seed for randomizing the test order, you can use the following command:

```sh
make test seed=1
```

### Running integration tests

To execute the integration tests, use the following command:

```sh
make test-integration
```

Make sure the app is uninstalled before running integration tests.

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
