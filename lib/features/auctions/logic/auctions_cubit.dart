import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/entity/auction_entity.dart';
import '../data/params/auction_params.dart';
import '../data/repo/auction_repo.dart';
import 'auctions_state.dart';

class AuctionsCubit extends Cubit<AuctionsState> {
  AuctionsCubit() : super(const AuctionsInitial());
//---------------------------------VARIABLES----------------------------------//

  List<AuctionEntity>? allAuctions;
  bool isList = false;

//---------------------------------FUNCTIONS----------------------------------//

  // updateListingCard() {
  //   isList = !isList;
  //   emit(ListingState());
  // }

//----------------------------------REQUEST-----------------------------------//
  Future<void> auctionStatesHandled({AuctionParams? params}) async {
    emit(const AuctionsLoading());
    final response = await AuctionRepo.auction(params);
    response.fold((failure) {
      return emit(AuctionsError(failure));
    }, (success) {
      allAuctions = success;
      emit(AuctionsSuccess(success));
    });
  }
}
