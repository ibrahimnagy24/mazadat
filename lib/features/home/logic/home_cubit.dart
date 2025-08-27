import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../category/data/entity/category_entity.dart';
import '../data/entity/home_auction_entity.dart';
import '../data/entity/home_bundle_entity.dart';
import '../data/enum/displayed_types.dart';
import '../data/enum/home_data_type.dart';
import '../data/params/home_auction_params.dart';
import '../data/params/home_bundle_params.dart';
import '../data/repo/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());
//---------------------------------VARIABLES----------------------------------//
  HomeDisplayedTypes displayedType = HomeDisplayedTypes.list;
  List<HomeBundleEntity>? homeBundles;
  List<HomeAuctionEntity>? homeAuctions;
  HomeDataType homeDataType = HomeDataType.auctions;
  CategoryEntity? _selectedCategory;
  bool _isBundleSelected = false;
  int _page = 0;
  int _limit = 20;

//---------------------------------FUNCTIONS----------------------------------//
  CategoryEntity? get getSelectedCategory => _selectedCategory;
  set selectedCategory(CategoryEntity? category) {
    _selectedCategory = category;
    if (category != null) {
      isBundleSelected = false;
      homeDataTypeChanged(type: HomeDataType.auctions);
    }
    if (category == null && _isBundleSelected == false) {
      isBundleSelected = false;
      homeDataTypeChanged(type: HomeDataType.auctions);
    }
    getSuitableData();
  }

  bool get getIsBundleSelected => _isBundleSelected;
  set isBundleSelected(bool value) {
    _isBundleSelected = value;
    if (value == true) {
      homeDataTypeChanged(type: HomeDataType.bundles);
      selectedCategory = null;
    }
    if (value == false) {
      homeDataTypeChanged(type: HomeDataType.auctions);
    }
    getSuitableData();
  }

  void updateOrToggleDisplayedType({HomeDisplayedTypes? type}) {
    if (type != null) {
      displayedType = type;
      emit(HomeDisplayedTypeChanged(displayedType: type));
      return;
    }
    displayedType = displayedType == HomeDisplayedTypes.list
        ? HomeDisplayedTypes.grid
        : HomeDisplayedTypes.list;
    emit(HomeDisplayedTypeChanged(displayedType: displayedType));
  }

  void homeDataTypeChanged({HomeDataType? type}) {
    if (type != null) {
      homeDataType = type;
      emit(HomeDataTypeChanged(homeDataType: type));
      return;
    }
    homeDataType = homeDataType == HomeDataType.auctions
        ? HomeDataType.bundles
        : HomeDataType.auctions;
    emit(HomeDataTypeChanged(homeDataType: homeDataType));
  }

  void getSuitableData() {
    if (homeDataType == HomeDataType.auctions) {
      _homeAuctionStatesHandled(
        HomeAuctionParams(
          size: _limit,
          page: _page,
          categoryId: _selectedCategory?.id,
        ),
      );
      return;
    }
    if (homeDataType == HomeDataType.bundles) {
      _homeBundleStatesHandled(
        HomeBundleParams(
          size: _limit,
          page: _page,
        ),
      );
      return;
    }
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> _homeAuctionStatesHandled(HomeAuctionParams params) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const HomeAutionsLoading());
    final response = await HomeRepo.homeAuction(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(HomeAutionsError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      homeAuctions = success;
      return emit(HomeAutionsSuccess(success));
    });
  }

  Future<void> _homeBundleStatesHandled(HomeBundleParams params) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const HomeBundlesLoading());
    final response = await HomeRepo.bundles(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(HomeBundlesError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      homeBundles = success;
      return emit(HomeBundlesSuccess(success));
    });
  }
}
