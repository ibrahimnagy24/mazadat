import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../home/data/enum/displayed_types.dart';
import '../data/entity/my_auction_entity.dart';
import '../data/enum/auction_status_type.dart';
import '../data/params/my_auctions_params.dart';
import '../data/repo/my_auctions_repo.dart';
import 'my_auctions_state.dart';

class MyAuctionsCubit extends Cubit<MyAuctionsState> {
  MyAuctionsCubit() : super(MyAuctionsInitial());
//---------------------------------VARIABLES----------------------------------//
  HomeDisplayedTypes displayedType = HomeDisplayedTypes.list;
  AuctionStatusType statusType = AuctionStatusType.ongoing;
  List<MyAuctionEntity>? myAuctions;
//---------------------------------FUNCTIONS----------------------------------//

  void updateOrToggleDisplayedType({HomeDisplayedTypes? type}) {
    if (type != null) {
      displayedType = type;
      emit(MyAuctionsDisplayedTypeChanged(displayedType: type));
      return;
    }
    displayedType = displayedType == HomeDisplayedTypes.list
        ? HomeDisplayedTypes.grid
        : HomeDisplayedTypes.list;
    emit(MyAuctionsDisplayedTypeChanged(displayedType: displayedType));
  }

  void setAuctionStatusType(AuctionStatusType type) {
    statusType = type;
    emit(MyAuctionsStatusTypeChanged(statusType: type));
  }

  AuctionStatusType get getAuctionStatusType => statusType;
  AuctionStatusType get getAuctionStatusTypeEndPoint => statusType;
//----------------------------------REQUEST-----------------------------------//
  Future<void> myAuctionsStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(MyAuctionsLoading());
    final response = await MyAuctionsRepo.myAuctions(
        MyAuctionsParams(status: getAuctionStatusTypeEndPoint.name));
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(MyAuctionsError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      myAuctions = success;
      return emit(MyAuctionsLoaded(success));
    });
  }
}
