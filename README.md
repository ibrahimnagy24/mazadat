<div align="center">

# 🏛️ Mazadat - بيت العسجدية

[![Flutter Version](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-success)](#supported-platforms)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#license)

**A comprehensive auction platform mobile application built with Flutter**

[Features](#-features) • [Getting Started](#-getting-started) • [Architecture](#-architecture) • [Tech Stack](#-tech-stack) • [Contributing](#-contributing)

</div>

---

## 📱 About

**Mazadat** (بيت العسجدية) is a modern, full-featured auction platform mobile application that enables users to participate in real-time auctions, manage purchases and sales, and engage with a comprehensive marketplace ecosystem. Built with Flutter for cross-platform compatibility and exceptional performance.

### 🎯 Key Highlights

- 🔥 **Real-time Bidding**: Live auction participation with WebSocket integration
- 🛍️ **Comprehensive Marketplace**: Browse, bid, and manage auctions seamlessly
- 🔔 **Smart Notifications**: FCM integration with in-app and push notifications
- 🎨 **Modern UI/UX**: Beautiful, responsive design with glassmorphism effects
- 🌐 **Multi-language Support**: Full Arabic and English localization
- 🏗️ **Clean Architecture**: Scalable, maintainable codebase following best practices

---

## 🚀 Features

### Core Functionality

#### 🏆 Auction Management
- **Browse Auctions**: Explore auctions with advanced filtering and search
- **Real-time Bidding**: Participate in live auctions with instant updates
- **Auction Details**: Comprehensive auction information with multimedia support
- **Bundle Auctions**: Special bundled auction participation
- **My Auctions**: Track and manage your active auction participations
- **My Sales**: Monitor your sold auction items

#### 🛒 Purchase & Sales
- **My Purchases**: View complete purchase history with detailed tracking
- **Order Tracking**: Real-time shipment status updates
- **Checkout Flow**: Seamless payment and address management
- **Shipment Details**: Comprehensive order information and tracking

#### 💳 Financial Management
- **Wallet System**: Manage your balance and transactions
- **Multiple Payment Methods**: Support for various payment gateways
- **Transaction History**: Complete financial record tracking
- **Secure Payments**: Integrated payment processing

#### 👤 User Profile & Management
- **Profile Management**: Edit personal information and preferences
- **Address Management**: Multiple address support with CRUD operations
- **Bank Details**: Secure banking information management
- **Favorite Categories**: Personalize your auction feed
- **Account Security**: Password management and account deletion

#### 🔔 Notifications & Communication
- **Push Notifications**: Firebase Cloud Messaging integration
- **In-app Notifications**: Beautiful custom notification UI
- **Notification Center**: Complete notification history with mark as read
- **Real-time Updates**: Pusher integration for live updates

#### ⭐ Additional Features
- **Favorites System**: Save and manage favorite auctions
- **Search**: Powerful search across auctions and categories
- **Contact Us**: Direct communication channel
- **FAQ**: Comprehensive help section
- **Static Pages**: Terms, privacy policy, and information pages

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK**: `>=3.9.2`
- **Dart SDK**: `>=3.9.2`
- **Android Studio** / **Xcode** (for mobile development)
- **Git**: For version control
- **Firebase Account**: For FCM and analytics

### Development Tools
```bash
# Verify Flutter installation
flutter doctor -v

# Check Dart version
dart --version
```

---

## 🛠️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-organization/mazadat.git
cd mazadat
```

### 2. Install Dependencies

```bash
# Install Flutter packages
flutter pub get

# Generate necessary files (if using code generation)
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Firebase Setup

1. Add your `google-services.json` (Android) to `android/app/`
2. Add your `GoogleService-Info.plist` (iOS) to `ios/Runner/`
3. Update Firebase configuration in `lib/firebase_options.dart`

### 4. Environment Configuration

The app supports multiple flavors (environments):

```dart
// lib/core/app_config/flavour.dart
Flavour.appFlavor = FlavorEnum.STAGING; // or PRODUCTION
```

Update API endpoints in `lib/core/app_config/app_config.dart`:
```dart
static String BASE_URL_STAGING = 'https://mazadat.api.innoeg.com';
static String BASE_URL_PRODUCTION = 'https://mazadat.api.innoeg.com';
```

### 5. Run the Application

#### Development Build
```bash
# Run on connected device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run with flavor
flutter run --flavor staging
```

#### Production Build
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ipa --release
```

---

## 📁 Project Structure

```
lib/
├── app/                          # App initialization and configuration
│   ├── app.dart                  # Main app widget
│   └── init_main_functions.dart  # Initialization logic
├── core/                         # Core utilities and shared resources
│   ├── app_config/              # App configuration and flavors
│   ├── assets/                  # Asset constants (SVG, images, fonts)
│   ├── global_favourites/       # Global favorites system
│   ├── helpers/                 # Utility helpers
│   ├── navigation/              # Navigation and routing
│   ├── services/                # Core services (API, FCM, Pusher)
│   ├── shared/                  # Shared widgets and BLoCs
│   ├── theme/                   # App theme and styling
│   ├── translation/             # Localization
│   └── utils/                   # Utilities and extensions
├── features/                     # Feature modules
│   ├── auth/                    # Authentication (login, register, etc.)
│   ├── home/                    # Home screen
│   ├── auctions/                # Auction listing
│   ├── auction_details/         # Auction details and bidding
│   ├── bundles/                 # Bundle auctions
│   ├── my_purchases/            # Purchase history
│   ├── my_sales/                # Sales management
│   ├── my_auctions/             # Active auction participation
│   ├── checkout/                # Checkout flow
│   ├── wallet/                  # Wallet management
│   ├── profile/                 # User profile
│   ├── notification/            # Notifications
│   ├── favourites/              # Favorites management
│   ├── address/                 # Address management
│   ├── search_module/           # Search functionality
│   └── ...                      # Other feature modules
├── firebase_options.dart         # Firebase configuration
└── main.dart                     # App entry point
```

### Feature Module Structure (Clean Architecture)

Each feature follows a consistent clean architecture pattern:

```
feature_name/
├── data/
│   ├── entity/              # Data entities
│   ├── model/               # Data models (JSON serialization)
│   ├── params/              # Request parameters
│   └── repo/                # Repository implementation
├── logic/
│   ├── feature_cubit.dart   # Business logic (BLoC/Cubit)
│   └── feature_state.dart   # State definitions
└── ui/
    ├── pages/               # Screen widgets
    └── widgets/             # Reusable UI components
```

---

## 🏗️ Architecture

### Design Patterns

- **Clean Architecture**: Separation of concerns (data, logic, UI)
- **BLoC Pattern**: State management using `flutter_bloc`
- **Repository Pattern**: Data abstraction layer
- **Singleton Pattern**: Core services (API, navigation, etc.)
- **MVVM**: Model-View-ViewModel for UI layer

### Key Architectural Principles

1. **Dependency Injection**: Using BLoC providers
2. **Separation of Concerns**: Clear layer boundaries
3. **Single Responsibility**: Each module has a single purpose
4. **DRY (Don't Repeat Yourself)**: Reusable components
5. **SOLID Principles**: Throughout the codebase

### State Management

```dart
// Example: Using BLoC for state management
BlocProvider(
  create: (context) => AuctionsCubit()..getAuctions(),
  child: AuctionsScreen(),
)

// Listening to state changes
BlocBuilder<AuctionsCubit, AuctionsState>(
  builder: (context, state) {
    if (state is AuctionsLoading) return LoadingWidget();
    if (state is AuctionsSuccess) return AuctionsList(state.auctions);
    if (state is AuctionsError) return ErrorWidget(state.error);
    return Container();
  },
)
```

---

## 🔧 Tech Stack

### Core Framework
- **Flutter** `^3.9.2` - UI framework
- **Dart** `^3.9.2` - Programming language

### State Management
- **flutter_bloc** `^7.0.0` - BLoC pattern implementation
- **rxdart** `^0.28.0` - Reactive programming
- **equatable** `^2.0.7` - Value equality

### Networking & Data
- **dio** `^5.7.0` - HTTP client
- **dartz** `^0.10.1` - Functional programming (Either pattern)
- **pretty_dio_logger** `^1.4.0` - Network logging
- **dio_cache_interceptor** `^3.5.1` - Response caching
- **internet_connection_checker** `^3.0.1` - Connectivity monitoring

### Local Storage
- **hive_flutter** `^1.1.0` - Local database
- **shared_preferences** `^2.5.3` - Key-value storage

### Real-time Communication
- **pusher_channels_flutter** `^2.5.0` - WebSocket for live bidding
- **firebase_messaging** `^15.1.4` - Push notifications
- **firebase_core** `^3.7.0` - Firebase SDK

### UI & Animation
- **flutter_svg** `^2.0.11` - SVG rendering
- **cached_network_image** `^3.4.1` - Image caching
- **shimmer** `^3.0.0` - Loading animations
- **flutter_staggered_animations** `^1.1.1` - List animations
- **flutter_animate** `^4.5.2` - Animation utilities
- **glassmorphism_widgets** `^0.2.2` - Glassmorphism effects
- **lottie** `^3.3.1` - Lottie animations
- **photo_view** `^0.15.0` - Image viewer

### Utilities
- **url_launcher** `^6.3.1` - External URL handling
- **image_picker** `^1.1.2` - Image selection
- **file_picker** `^8.1.6` - File selection
- **share_plus** `^10.0.3` - Share functionality
- **permission_handler** `^11.3.1` - Permissions
- **app_settings** `^5.1.1` - App settings
- **device_info_plus** `^11.3.0` - Device information
- **package_info_plus** `^8.3.0` - Package information

### Navigation
- **go_router** `^15.1.1` - Declarative routing
- **modal_bottom_sheet** `^3.0.0` - Bottom sheets

### Media
- **video_player** `^2.10.0` - Video playback
- **just_audio** `^0.9.33` - Audio playback
- **audio_waveforms** `^1.2.0` - Audio visualization

### Forms & Input
- **pin_code_fields** `^8.0.1` - OTP input
- **flutter_form_builder** `^10.0.1` - Form building

### UI Components
- **iconsax** `^0.0.8` - Icon pack
- **google_fonts** `^6.2.1` - Custom fonts
- **expandable** `^5.0.1` - Expandable widgets
- **expandable_text** `^2.3.0` - Text expansion
- **dotted_border** `^3.0.1` - Dotted borders

### Development Tools
- **flutter_lints** `^4.0.0` - Linting rules
- **flutter_native_splash** `^2.4.6` - Splash screen
- **flutter_launcher_icons** `^0.14.2` - App icons

---

## 🌐 Supported Platforms

| Platform | Status | Min Version |
|----------|--------|-------------|
| Android  | ✅ Supported | API 27 (Android 8.1) |
| iOS      | ✅ Supported | iOS 12.0+ |
| Web      | ⏳ Planned | - |
| Desktop  | ⏳ Future | - |

### Platform-specific Features

#### Android
- Deep linking support
- Firebase Cloud Messaging
- Google Services integration
- Multi-dex enabled

#### iOS
- Universal links
- APNs integration
- Background fetch

---

## 🔒 Security Features

- **Secure Authentication**: JWT token-based authentication
- **Encrypted Storage**: Sensitive data encryption
- **SSL Pinning**: Network security (can be configured)
- **Secure Payment Processing**: PCI-compliant payment handling
- **Input Validation**: Comprehensive form validation
- **API Security**: Token refresh and expiration handling

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

### Test Structure
```
test/
├── unit/           # Unit tests
├── widget/         # Widget tests
└── integration/    # Integration tests
```

---

## 📦 Building for Production

### Android

```bash
# Generate release APK
flutter build apk --release

# Generate release App Bundle (recommended for Play Store)
flutter build appbundle --release

# Build output location:
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### iOS

```bash
# Generate release build
flutter build ios --release

# Generate IPA for distribution
flutter build ipa --release

# Build output location:
# build/ios/ipa/*.ipa
```

### Build Configuration

Ensure you have configured signing:
- **Android**: `key.properties` file with keystore configuration
- **iOS**: Xcode signing certificates and provisioning profiles

---

## 🔄 Version Management

Current Version: **1.0.1+15**

- **Version Name**: `1.0.1`
- **Build Number**: `15`

Update version in `pubspec.yaml`:
```yaml
version: 1.0.1+15
```

---

## 🌍 Localization

The app supports multiple languages with full RTL support:

- **Arabic** (ar) - Primary language
- **English** (en) - Secondary language

### Adding Translations

Translation files are located in `assets/langs/`:
```
assets/langs/
├── ar.json
└── en.json
```

Usage in code:
```dart
Text(allTranslations.text('key_name'))
```

---

## 🎨 Theming

The app uses a comprehensive theming system:

```dart
// Primary color
AppColors.kPrimary // rgba(81, 94, 50, 1)

// Theme configuration in app.dart
ThemeData(
  primaryColor: AppColors.kPrimary,
  colorScheme: ColorScheme.light(
    primary: AppColors.kPrimary,
    secondary: AppColors.kPrimary300,
  ),
)
```

---

## 🚀 Performance Optimizations

- **Image Caching**: Using `cached_network_image`
- **Response Caching**: Dio cache interceptor
- **Lazy Loading**: Pagination for lists
- **Widget Optimization**: Const constructors where possible
- **Code Splitting**: Feature-based module loading
- **Build Optimization**: Release mode optimizations

---

## 🐛 Debugging

### Enable Debug Mode

```dart
// main.dart
Flavour.appFlavor = FlavorEnum.STAGING;
```

### Logging

The app uses custom logging utilities:
```dart
cprint('Debug message'); // Custom print with formatting
```

### Network Debugging

Network requests are logged in debug mode using `pretty_dio_logger`.

---

## 📝 Code Style Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter_lints` for code analysis
- Maintain consistent naming conventions:
  - **Classes**: `PascalCase`
  - **Variables/Functions**: `camelCase`
  - **Constants**: `UPPER_SNAKE_CASE`
  - **Private**: `_leadingUnderscore`

```bash
# Run linter
flutter analyze

# Format code
flutter format .
```

---

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Workflow

1. Ensure all tests pass
2. Follow code style guidelines
3. Update documentation as needed
4. Add tests for new features
5. Request code review

---

## 📞 Support

For support and questions:

- **Email**: support@innoeg.com
- **Documentation**: [Project Wiki](link-to-wiki)
- **Issue Tracker**: [GitHub Issues](link-to-issues)

---

## 📄 License

This project is proprietary software owned by **INOVA-DIGITS**. All rights reserved.

**Unauthorized copying, distribution, or modification is prohibited.**

---

## 👥 Authors & Acknowledgments

### Development Team
- **INOVA-DIGITS Development Team**

### Special Thanks
- Flutter Team for the amazing framework
- Open source community for excellent packages
- All contributors and testers

---

## 📊 Project Stats

- **Lines of Code**: 50,000+
- **Features**: 35+ modules
- **Dependencies**: 70+ packages
- **Supported Languages**: 2 (Arabic, English)
- **Platforms**: Android, iOS

---

## 🗺️ Roadmap

### Upcoming Features
- [ ] Web platform support
- [ ] Desktop platform support
- [ ] Enhanced analytics dashboard
- [ ] Advanced search filters
- [ ] Social sharing improvements
- [ ] Offline mode support

### Future Enhancements
- [ ] AI-powered auction recommendations
- [ ] Live streaming integration
- [ ] Multi-currency support
- [ ] Enhanced security features

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase Documentation](https://firebase.google.com/docs)
- [BLoC Pattern Guide](https://bloclibrary.dev/)

---

<div align="center">

**Built with ❤️ by INOVA-DIGITS**


</div>
