import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/shared/entity/error_entity.dart';
import '../data/model/auction_details_model.dart';
import '../data/params/auction_details_route_params.dart';
import '../data/repo/auction_details_repo.dart';
part 'view_auction_state.dart';

class AuctionDetailsCubit extends Cubit<AuctionDetailsState> {
  AuctionDetailsCubit() : super(AuctionDetailsInitial()) {
    updateImageIndex(0);
  }

//---------------------------------VARIABLES----------------------------------//

//---------------------------------FUNCTIONS----------------------------------//

  /// Select a specific image from the gallery
  final imageIndex = BehaviorSubject<int>();
  Function(int) get updateImageIndex => imageIndex.sink.add;
  Stream<int> get imageIndexStream => imageIndex.stream.asBroadcastStream();

//----------------------------------REQUEST-----------------------------------//

  Future<void> auctionDetailsStatesHandled(
      AuctionDetailsRouteParams params) async {
    emit(const AuctionDetailsLoading());

    final response = await AuctionDetailsRepo.getAuctionDetails(params);
    response.fold((failure) {
      return emit(AuctionDetailsError(failure));
    }, (success) {
      if (success.statusCode == 200) {
        AuctionDetailsModel? res =
            AuctionDetailsModel.fromJson(success.data['DATA']);
        int currentIndex =
            res.images?.indexWhere((e) => e == params.primaryImage) ?? 0;
        updateImageIndex(currentIndex == -1 ? 0 : currentIndex);

        return emit(AuctionDetailsSuccess(AuctionDetails: res));
      } else {
        return emit(AuctionDetailsError(ErrorEntity(
            message: success.data['MESSAGE'],
            statusCode: success.statusCode ?? 400,
            errors: const [])));
      }
    });
  }
}
