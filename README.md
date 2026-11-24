<!-- README.md -->

# BLoC Login

A Flutter authentication app (login and registration) built with the BLoC pattern and a feature-first, layered architecture. It was built incrementally as a hands-on way to learn BLoC, moving from a hardcoded credential check to local storage and finally to a real network layer.

## Features

- **Login and registration** driven by `AuthBloc` (events in, states out)
- **Network layer** using Dio against [reqres.in](https://reqres.in), a public fake REST API, with timeout and status-code error mapping
- **Session persistence** with Hive: the user stays signed in across app restarts
- **Remember me** pre-fills the saved email on the login form and survives logout
- **Form validation** for email format and password rules, with inline errors
- **Password visibility toggle** via `password_text_field`
- **Live password strength meter** on the register screen via `password_strength_checker`
- **Modest card-based UI** (Material 3), capped at 400 px wide and centered on the page

## Tech stack

| Concern | Package |
| --- | --- |
| State management | `flutter_bloc`, `equatable` |
| Networking | `dio` |
| Local storage | `hive`, `hive_flutter` |
| Password field UI | `password_text_field` |
| Password strength | `password_strength_checker` |

## Getting started

### Prerequisites

- Flutter SDK (Dart `>=3.3.0 <4.0.0`)
- Chrome, if you want to run on the web

### Install and run

```powershell
flutter pub get
flutter run -d chrome
```

To run on a connected device or emulator instead, use `flutter devices` to list targets and `flutter run -d <device-id>`.

## Test credentials

The app talks to reqres.in, which only accepts specific users:

| Action | Email | Password |
| --- | --- | --- |
| Register | `eve.holt@reqres.in` | `pistol` |
| Login | `eve.holt@reqres.in` | any password that passes the form validator |

Any other email returns a `400` from the API, which the app shows as a snackbar error. That is expected behavior of the test API, not a bug.

## Architecture

Feature-first, with three layers inside each feature. The bloc only ever depends on the `AuthRepository` interface, so swapping Hive or Dio for something else only touches the data layer.

```
lib/
  core/
    network/
      api_constants.dart               Base URL, endpoints, timeouts
      dio_client.dart                  Configured Dio instance
    storage/
      auth_box.dart                    Hive box name and storage keys
    utils/
      validators.dart                  Email, password, confirm-password rules
  features/
    auth/
      domain/
        auth_repository.dart           Repository contract (abstract class)
        auth_failure.dart              Exception type surfaced to the UI
      data/
        datasources/
          auth_remote_data_source.dart       Network contract
          auth_remote_data_source_impl.dart  Dio calls and error mapping
        auth_repository_impl.dart      Calls the remote source, persists to Hive
      presentation/
        bloc/
          auth_bloc.dart               Event handlers
          auth_event.dart              AppStarted, LoginRequested, RegisterRequested, LogoutRequested
          auth_state.dart              AuthStatus and AuthState
        pages/
          login_page.dart
          register_page.dart
          home_page.dart
  app.dart                             MaterialApp and status-driven screen switch
  main.dart                            Dependency wiring and app entry point
```

### How the layers fit together

- **Presentation** dispatches events to `AuthBloc` and renders whatever `AuthState` comes back. `app.dart` picks the screen from `AuthState.status`: authenticated shows `HomePage`, initial shows a spinner, and everything else shows `LoginPage`.
- **Domain** holds the `AuthRepository` contract and `AuthFailure`. It has no knowledge of Hive, Dio, or Flutter.
- **Data** is the only layer that knows how things are fetched and stored. `AuthRemoteDataSourceImpl` makes the HTTP calls and maps Dio errors to `AuthFailure`. `AuthRepositoryImpl` takes the returned token and writes the session (logged-in flag, email, token) to Hive.

### Auth flow

1. `AppStarted` fires on launch. The bloc checks the stored session flag and any remembered email, then emits `authenticated` or `unauthenticated`.
2. `LoginRequested` and `RegisterRequested` emit `loading`, call the repository, then emit `authenticated` on success or `failed` with an error message on `AuthFailure`.
3. `LogoutRequested` clears the session keys but leaves the remembered email in place.

## Error handling

`AuthRemoteDataSourceImpl` translates network failures into user-facing `AuthFailure` messages:

| Condition | Message source |
| --- | --- |
| Connect, send, or receive timeout | "Connection timed out. Check your network." |
| No connection | "Unable to connect. Check your network." |
| `400`, `401`, `404` | The API's own `error` text, with a fallback |
| `500` | "Server error. Please try again later." |
| Anything else | "Something went wrong. Please try again." |

## Known limitations

- **Login uses the registration password rules.** The login form validates with `Validators.password` (8+ characters with upper, lower, digit, and special character), so a password that is valid for the API but fails those rules is blocked client-side. Login arguably should only check that the field is not empty.
- **Register password pattern validation is disabled.** The register password field relies on the strength meter for feedback, and `Validators.password` is commented out there, so a weak password can still be submitted.
- **Token stored in Hive.** Hive is not encrypted by default. For a real backend, store the token in `flutter_secure_storage`.
- **Request logging is on.** `DioClient` attaches a `LogInterceptor` that prints request and response bodies. Remove it or gate it behind a debug flag for release builds.
- **Fake API.** reqres.in is a test service. The token it returns is not a real credential and there is no token refresh or expiry handling.

## Roadmap

- Secure token storage with `flutter_secure_storage`
- Declarative navigation with GoRouter and a bloc-driven redirect
- Separate login and registration validators
- Token attachment and `401` handling via a Dio interceptor
- Unit tests for `AuthBloc` and the repository
