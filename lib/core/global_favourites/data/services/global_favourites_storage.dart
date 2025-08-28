import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalFavouritesStorage {
  static const String _favouritesKey = 'global_favourites_ids';

  // Get favourite IDs from local storage
  Future<Set<int>> getFavouriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favouritesJson = prefs.getString(_favouritesKey);

      if (favouritesJson == null) {
        return <int>{};
      }

      final List<dynamic> favouritesList = json.decode(favouritesJson);
      return favouritesList.cast<int>().toSet();
    } catch (e) {
      return <int>{};
    }
  }

  /// Save favourite IDs to local storage
  Future<void> saveFavouriteIds(Set<int> favouriteIds) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favouritesJson = json.encode(favouriteIds.toList());
      await prefs.setString(_favouritesKey, favouritesJson);
    } catch (e) {
      // Handle error silently or log it
    }
  }

  /// Clear all favourite IDs from local storage
  Future<void> clearFavouriteIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favouritesKey);
    } catch (e) {
      // Handle error silently or log it
    }
  }

  /// Check if favourites exist in local storage
  Future<bool> hasFavourites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_favouritesKey);
    } catch (e) {
      return false;
    }
  }
}
