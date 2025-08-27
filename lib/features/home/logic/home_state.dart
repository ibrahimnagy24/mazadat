import '../../../core/shared/entity/error_entity.dart';
import '../../category/data/entity/category_entity.dart';
import '../data/entity/home_auction_entity.dart';
import '../data/entity/home_bundle_entity.dart';
import '../data/enum/displayed_types.dart';
import '../data/enum/home_data_type.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeDisplayedTypeChanged extends HomeState {
  final HomeDisplayedTypes displayedType;
  HomeDisplayedTypeChanged({required this.displayedType});
}

final class HomeDataTypeChanged extends HomeState {
  final HomeDataType homeDataType;
  HomeDataTypeChanged({required this.homeDataType});
}

final class HomeAutionsLoading extends HomeState {
  const HomeAutionsLoading();
}

final class HomeAutionsSuccess extends HomeState {
  final List<HomeAuctionEntity> auctions;
  HomeAutionsSuccess(this.auctions);
}

final class HomeAutionsError extends HomeState {
  final ErrorEntity error;
  HomeAutionsError(this.error);
}

final class HomeBundlesLoading extends HomeState {
  const HomeBundlesLoading();
}

final class HomeBundlesSuccess extends HomeState {
  final List<HomeBundleEntity> bundles;
  HomeBundlesSuccess(this.bundles);
}

final class HomeBundlesError extends HomeState {
  final ErrorEntity error;
  HomeBundlesError(this.error);
}
