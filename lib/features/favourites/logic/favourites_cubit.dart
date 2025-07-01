import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auctions/data/entity/auction_entity.dart';
import '../data/params/favourites_params.dart';
import '../data/repo/favourites_repo.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(const FavouritesInitial());
//---------------------------------VARIABLES----------------------------------//

  List<AuctionEntity>? allAuctions;
  bool isList = false;

//---------------------------------FUNCTIONS----------------------------------//

  // updateListingCard() {
  //   isList = !isList;
  //   emit(ListingState());
  // }

//----------------------------------REQUEST-----------------------------------//
  Future<void> favouritesAuctionStatesHandled({FavouritesParams? params}) async {
    emit(const FavouritesLoading());
    final response = await FavouritesRepo.favouritesAuction(params);
    response.fold((failure) {
      return emit(FavouritesError(failure));
    }, (success) {
      allAuctions = success;
      emit(FavouritesSuccess(success));
    });
  }
}
