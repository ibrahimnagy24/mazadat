import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_config/api_names.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/home_auction_entity.dart';
import '../data/enums/home_enums.dart';
import '../data/repo/home_repo.dart';
import '../data/params/home_auction_params.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());
//---------------------------------VARIABLES----------------------------------//
  List<HomeAuctionEntity>? featuredAuction;
  List<HomeAuctionEntity>? upcomingAuction;
  List<HomeAuctionEntity>? inProgressAuction;
  HomeTitleType _homeTitleType = HomeTitleType.auction;
//---------------------------------FUNCTIONS----------------------------------//
  HomeTitleType get getHomeTitleType => _homeTitleType;

  set setHomeTitleType(HomeTitleType homeTitleType) {
    if (_homeTitleType == homeTitleType) return;
    _homeTitleType = homeTitleType;
    emit(HomeTitleTypeChanged());
  }

  String _getAuctionTypeEndpoint(HomeAuctionType auctionType) {
    switch (auctionType) {
      case HomeAuctionType.featured:
        return Endpoints.featuredAuction;
      case HomeAuctionType.inProgress:
        return Endpoints.inProgressAuction;
      case HomeAuctionType.upComing:
        return Endpoints.upComingAuction;
    }
  }

  void _getAuctionTypeLoadingState(HomeAuctionType auctionType) {
    switch (auctionType) {
      case HomeAuctionType.featured:
        return emit(const HomeFeaturedAuctionLoading());
      case HomeAuctionType.inProgress:
        return emit(const HomeInProgressAuctionLoading());
      case HomeAuctionType.upComing:
        return emit(const HomeUpComingAuctionLoading());
    }
  }

  void _getAuctionTypeSuccessState(
    HomeAuctionType auctionType,
    List<HomeAuctionEntity> success,
  ) {
    switch (auctionType) {
      case HomeAuctionType.featured:
        featuredAuction = success;
        return emit(HomeFeaturedAuctionSuccess(success));
      case HomeAuctionType.inProgress:
        inProgressAuction = success;
        return emit(HomeInProgressAuctionSuccess(success));
      case HomeAuctionType.upComing:
        upcomingAuction = success;
        return emit(HomeUpComingAuctionSuccess(success));
    }
  }

  void _getAuctionTypeErrorState(
    HomeAuctionType auctionType,
    ErrorEntity error,
  ) {
    switch (auctionType) {
      case HomeAuctionType.featured:
        return emit(HomeFeaturedAuctionError(error));
      case HomeAuctionType.inProgress:
        return emit(HomeInProgressAuctionError(error));
      case HomeAuctionType.upComing:
        return emit(HomeUpComingAuctionError(error));
    }
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> auctionStatesHandled(HomeAuctionType auctionType) async {
    _getAuctionTypeLoadingState(auctionType);
    final response = await HomeRepo.auction(
      HomeAuctionParams(
        endPoint: _getAuctionTypeEndpoint(auctionType),
      ),
    );
    response.fold((failure) {
      return _getAuctionTypeErrorState(auctionType, failure);
    }, (success) {
      _getAuctionTypeSuccessState(auctionType, success);
    });
  }
}
