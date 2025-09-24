import 'package:flutter/material.dart';
import '../../../core/utils/utility.dart';
import 'favourites_cubit.dart';

/// Service to handle global favourites initialization
/// Call this from your main app initialization
class FavouritesService {
  static bool _isInitialized = false;

  /// Initialize favourites once at app startup
  /// Call this from your main app after user login
  static Future<void> initializeGlobalFavourites(BuildContext context) async {
    if (_isInitialized) return; // Already initialized, skip

    if (Utility.isUserLoggedIn()) {
      _isInitialized = true;

      try {
        await FavouritesCubit.instance.loadFavouritesFromServer();
        cprint('✅ Favourites initialized successfully');
      } catch (e) {
        cprint('❌ Failed to initialize favourites: $e');
      }
    }
  }

  /// Reset initialization flag (call when user logs out)
  static void resetInitialization() {
    _isInitialized = false;
  }

  /// Check if favourites are initialized
  static bool get isInitialized => _isInitialized;
}
