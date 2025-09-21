import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../../auctions/data/entity/auction_entity.dart';
import '../../auctions/data/model/auction_model.dart';
import '../data/params/toggle_favourites_params.dart';
import '../data/repo/favourites_repo.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  static FavouritesCubit? _instance;
  
  // Singleton pattern to survive widget disposal
  static FavouritesCubit get instance {
    _instance ??= FavouritesCubit._internal();
    return _instance!;
  }
  
  FavouritesCubit._internal() : super(const FavouritesInitial()) {
    controller = ScrollController();
    customScroll(controller);
    // NO automatic initialization - will be called manually when needed
  }
  
  // Factory constructor for BlocProvider
  factory FavouritesCubit() => instance;
//---------------------------------VARIABLES----------------------------------//

  late ScrollController controller;
  late SearchEngine _engine;
  List<AuctionEntity>? model;
  
  // Global favourites tracking (memory only - no storage)
  final Set<int> _favouriteIds = <int>{};

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        favouritesAuctionStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> favouritesAuctionStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const FavouritesLoading());
    } else {
      emit(FavouritesSuccess(auctions: model!, isLoading: true));
    }

    final response = await FavouritesRepo.favouritesAuction(params);
    response.fold((failure) {
      return emit(FavouritesError(failure));
    }, (success) {
      try {
        // Parse the response to extract auction data
        final responseData = success.data;
        if (responseData != null && responseData['content'] != null) {
          final List<dynamic> contentList = responseData['content'];
          
          if (_engine.currentPage == -1) {
            model?.clear();
            _favouriteIds.clear();
          }
          
          // Parse auctions and extract IDs
          for (var item in contentList) {
            final auction = AuctionModel.fromJson(item);
            _favouriteIds.add(auction.id);
            model?.removeWhere((e) => e.id == auction.id);
            model?.add(auction);
          }
          
          // Update pagination info
          if (responseData['pageable'] != null) {
            _engine.maxPages = responseData['pageable']['totalPages'] ?? 1;
            _engine.updateCurrentPage(responseData['pageable']['number'] ?? 0);
          }
          
          // Emit updated state for favourite buttons
          emit(FavouritesUpdated(favouriteIds: _favouriteIds));
        }
        
        if (model != null && model!.isNotEmpty) {
          return emit(FavouritesSuccess(auctions: model!, isLoading: false));
        } else {
          return emit(const FavouritesEmpty());
        }
      } catch (e) {
        return emit(FavouritesError(ErrorEntity(
          statusCode: 500, 
          message: 'Failed to parse favourites data: $e',
          errors: null,
        )));
      }
    });
  }

  Future<void> toggleFavouriteAuction(ToggleFavouritesParams params) async {
    try {
      loadingDialog();

      final response = await FavouritesRepo.toggleFavoriteAuction(params);
      CustomNavigator.pop();

      response.fold((fail) {
        return showErrorSnackBar(fail.message);
      }, (success) {
        showSuccessSnackBar(success.data['MESSAGE']);
        
        // After successful toggle, reload all favourites from server to get updated list
        favouritesAuctionStatesHandled(SearchEngine(currentPage: -1, limit: 10000));
      });
    } catch (e) {
      CustomNavigator.pop();
      return showErrorSnackBar(e.toString());
    }
  }

  //---------------------------------NO STORAGE - MEMORY ONLY-------------------//

  //---------------------------------PUBLIC METHODS-----------------------------//
  
  /// Load favourites from server (public method for service to call)
  Future<void> loadFavouritesFromServer() async {
    await favouritesAuctionStatesHandled(SearchEngine(currentPage: -1, limit: 10000));
  }
  
  /// Check if favourites are already loaded and emit appropriate state
  void ensureFavouritesLoaded() {
    if (model != null && model!.isNotEmpty) {
      // Data already loaded, emit success state
      emit(FavouritesSuccess(auctions: model!, isLoading: false));
    } else if (_favouriteIds.isEmpty && state is! FavouritesLoading) {
      // No favourites, emit empty state
      emit(const FavouritesEmpty());
    }
  }
  
  /// Check if an auction is marked as favourite
  bool isFavourite(int? auctionId) {
    if (auctionId == null) return false;
    return _favouriteIds.contains(auctionId);
  }
  
  /// Get the total count of favourite auctions
  int get favouritesCount => _favouriteIds.length;
  
  /// Get a copy of all favourite auction IDs
  Set<int> get favouriteIds => Set.unmodifiable(_favouriteIds);
  
  /// Reset favourites data (call when user logs out)
  void resetFavourites() {
    _favouriteIds.clear();
    model?.clear();
    emit(const FavouritesInitial());
  }
}
