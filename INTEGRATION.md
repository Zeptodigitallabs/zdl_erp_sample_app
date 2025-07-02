# zdl_erp_sdk Integration Guide

This document explains how to integrate the `zdl_erp_sdk` package into your Flutter application, as implemented in this project.

## 1. Add the Dependency

In your `pubspec.yaml` file, add the following under `dependencies`:

```yaml
dependencies:
  zdl_erp_sdk: ^0.0.3
```

Then run:

```sh
flutter pub get
```

## 2. Import the SDK

Import the SDK in the Dart files where you need to use it:

```dart
import 'package:zdl_erp_sdk/zdl_erp_sdk.dart';
import 'package:zdl_erp_sdk/models/zdl_erp_options.dart';
```

## 3. Initialize and Launch the SDK

To authenticate a user and launch the ERP SDK, use the following pattern (see `lib/ui/views/login/login_viewModel.dart`):

```dart
await ZdlErpSdk.instance.initialiseZDLErpSdk(
  ZDLErpOptions(
    userName: <USERNAME>,
    password: <PASSWORD>,
    userRole: <UserRole>,
    messageId: <MESSAGE_ID>,
    appBaseUrl: <BASE_URL>,
    appPackageName: <PACKAGE_NAME>,
  ),
);
final response = await ZdlErpSdk.instance.launchErpSdk(false);
```

- Replace `<USERNAME>`, `<PASSWORD>`, `<UserRole>`, `<MESSAGE_ID>`, `<BASE_URL>`, and `<PACKAGE_NAME>` with your actual values.
- `UserRole` is an enum from the SDK (e.g., `UserRole.student`).

## 4. Error Handling

Wrap SDK calls in a try-catch block to handle exceptions and show error dialogs as needed.

## 5. Example Usage

See `lib/ui/views/login/login_viewModel.dart` for a complete example of integrating and using the SDK for user authentication.

---

For more details, refer to the official SDK documentation or the code comments in this project.

