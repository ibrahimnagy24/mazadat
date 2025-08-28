import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/favourites/data/params/toggle_favourites_params.dart';
import '../../../features/favourites/data/enums/toggle_favorite_auction_enum.dart';
import '../../../features/favourites/data/repo/favourites_repo.dart';
import '../../app_core.dart';
import '../data/services/global_favourites_storage.dart';
import 'global_favourites_state.dart';

class GlobalFavouritesCubit extends Cubit<GlobalFavouritesState> {
  static GlobalFavouritesCubit? _instance;
  static GlobalFavouritesCubit get instance => _instance ??= GlobalFavouritesCubit._internal();
  
  GlobalFavouritesCubit._internal() : super(const GlobalFavouritesInitial()) {
    _loadFavourites();
  }

  final GlobalFavouritesStorage _storage = GlobalFavouritesStorage();
  Set<int> _favouriteIds = <int>{};

  // Getters
  Set<int> get favouriteIds => Set.unmodifiable(_favouriteIds);
  bool get isLoaded => state is GlobalFavouritesLoaded;
  bool get isLoading => state is GlobalFavouritesLoading;

  /// Initialize favourites from local storage
  Future<void> _loadFavourites() async {
    emit(const GlobalFavouritesLoading());
    try {
      _favouriteIds = await _storage.getFavouriteIds();
      emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
    } catch (e) {
      emit(GlobalFavouritesError(message: e.toString()));
    }
  }

  /// Check if an item is favourite
  bool isFavourite(int itemId) {
    return _favouriteIds.contains(itemId);
  }

  /// Get all favourite IDs
  Set<int> getAllFavouriteIds() {
    return Set.unmodifiable(_favouriteIds);
  }

  /// Get favourite count
  int getFavouriteCount() {
    return _favouriteIds.length;
  }

  /// Toggle favourite status for an item
  Future<void> toggleFavourite(int itemId, {Function()? onSuccess}) async {
    try {
      final isCurrentlyFavourite = _favouriteIds.contains(itemId);
      final action = isCurrentlyFavourite 
          ? ToggleFavoriteAuctions.UNFAVORITE 
          : ToggleFavoriteAuctions.FAVORITE;

      // Emit toggling state
      emit(GlobalFavouritesToggling(
        itemId: itemId,
        favouriteIds: _favouriteIds,
      ));

      // Create params for API call
      final params = ToggleFavouritesParams(
        id: itemId,
        action: action,
        onSuccess: onSuccess,
      );

      // Call API
      final response = await FavouritesRepo.toggleFavoriteAuction(params);
      
      response.fold(
        (failure) {
          // Revert to previous state on failure
          emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
          showErrorSnackBar(failure.message);
        },
        (success) {
          // Update local state
          if (isCurrentlyFavourite) {
            _favouriteIds.remove(itemId);
          } else {
            _favouriteIds.add(itemId);
          }

          // Save to local storage
          _storage.saveFavouriteIds(_favouriteIds);

          // Emit success state
          emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
          
          // Show success message
          showSuccessSnackBar(success.data['MESSAGE']);
          
          // Call success callback
          onSuccess?.call();
        },
      );
    } catch (e) {
      emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
      showErrorSnackBar(e.toString());
    }
  }

  /// Add item to favourites
  Future<void> addToFavourites(int itemId, {Function()? onSuccess}) async {
    if (!_favouriteIds.contains(itemId)) {
      await toggleFavourite(itemId, onSuccess: onSuccess);
    }
  }

  /// Remove item from favourites
  Future<void> removeFromFavourites(int itemId, {Function()? onSuccess}) async {
    if (_favouriteIds.contains(itemId)) {
      await toggleFavourite(itemId, onSuccess: onSuccess);
    }
  }

  /// Clear all favourites (local only - doesn't call API)
  Future<void> clearAllFavourites() async {
    _favouriteIds.clear();
    await _storage.saveFavouriteIds(_favouriteIds);
    emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
  }

  /// Refresh favourites from server
  Future<void> refreshFavourites() async {
    await _loadFavourites();
  }

  /// Sync local favourites with a list of IDs (useful after fetching from server)
  Future<void> syncFavouriteIds(Set<int> serverFavouriteIds) async {
    _favouriteIds = serverFavouriteIds;
    await _storage.saveFavouriteIds(_favouriteIds);
    emit(GlobalFavouritesLoaded(favouriteIds: _favouriteIds));
  }

  /// Check if multiple items are favourites
  Map<int, bool> checkMultipleFavourites(List<int> itemIds) {
    return {
      for (int id in itemIds) id: _favouriteIds.contains(id)
    };
  }

  /// Get items that are favourites from a list
  List<int> filterFavourites(List<int> itemIds) {
    return itemIds.where((id) => _favouriteIds.contains(id)).toList();
  }

  /// Get items that are not favourites from a list
  List<int> filterNonFavourites(List<int> itemIds) {
    return itemIds.where((id) => !_favouriteIds.contains(id)).toList();
  }
}
