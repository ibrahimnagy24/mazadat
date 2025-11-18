import '../logic/global_favourites_cubit.dart';

/// Global Favourites Service - Easy access to favourites functionality
/// This service provides static methods for easy access to favourites from anywhere in the app
class GlobalFavouritesService {
  static GlobalFavouritesCubit get _cubit => GlobalFavouritesCubit.instance;

  /// Check if an item is favourite
  static bool isFavourite(int itemId) {
    return _cubit.isFavourite(itemId);
  }

  /// Toggle favourite status for an item
  static Future<void> toggleFavourite(int itemId, {Function()? onSuccess}) async {
    await _cubit.toggleFavourite(itemId, onSuccess: onSuccess);
  }

  /// Add item to favourites
  static Future<void> addToFavourites(int itemId, {Function()? onSuccess}) async {
    await _cubit.addToFavourites(itemId, onSuccess: onSuccess);
  }

  /// Remove item from favourites
  static Future<void> removeFromFavourites(int itemId, {Function()? onSuccess}) async {
    await _cubit.removeFromFavourites(itemId, onSuccess: onSuccess);
  }

  /// Get all favourite IDs
  static Set<int> getAllFavouriteIds() {
    return _cubit.getAllFavouriteIds();
  }

  /// Get favourite count
  static int getFavouriteCount() {
    return _cubit.getFavouriteCount();
  }

  /// Check if multiple items are favourites
  static Map<int, bool> checkMultipleFavourites(List<int> itemIds) {
    return _cubit.checkMultipleFavourites(itemIds);
  }

  /// Get items that are favourites from a list
  static List<int> filterFavourites(List<int> itemIds) {
    return _cubit.filterFavourites(itemIds);
  }

  /// Get items that are not favourites from a list
  static List<int> filterNonFavourites(List<int> itemIds) {
    return _cubit.filterNonFavourites(itemIds);
  }

  /// Clear all favourites (local only)
  static Future<void> clearAllFavourites() async {
    await _cubit.clearAllFavourites();
  }

  /// Refresh favourites from server
  static Future<void> refreshFavourites() async {
    await _cubit.refreshFavourites();
  }

  /// Sync local favourites with server IDs
  static Future<void> syncFavouriteIds(Set<int> serverFavouriteIds) async {
    await _cubit.syncFavouriteIds(serverFavouriteIds);
  }

  /// Get the cubit instance for BlocBuilder/BlocListener usage
  static GlobalFavouritesCubit getCubit() {
    return _cubit;
  }

  /// Check if favourites are loaded
  static bool get isLoaded => _cubit.isLoaded;

  /// Check if favourites are loading
  static bool get isLoading => _cubit.isLoading;
}
