import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../data/entity/auction_types_entity.dart';
import '../data/repo/auction_statuses_repo.dart';
part 'auction_statuses_state.dart';

class AuctionStatusesCubit extends Cubit<AuctionStatusesState> {
  AuctionStatusesCubit() : super(AuctionStatusesStart());
//---------------------------------VARIABLES----------------------------------//
  List<AuctionStatusesEntity>? _allAuctionTypes;

//---------------------------------FUNCTIONS----------------------------------//
  List<AuctionStatusesEntity>? get allAuctionTypes => _allAuctionTypes;

  Future<void> auctionStatusesStatesHandled() async {
    emit(AuctionStatusesLoading());
    final response = await AuctionStatusesRepo.getAuctionStatuses();
    response.fold((failure) {
      return emit(AuctionStatusesError(failure));
    }, (success) async {
      _allAuctionTypes = success;
      if (_allAuctionTypes != null && _allAuctionTypes!.isNotEmpty) {
        return emit(AuctionStatusesDone(success));
      } else {
        return emit(AuctionStatusesEmpty());
      }
    });
  }
}
