import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../data/entity/auction_entity.dart';
import '../data/enum/display_types.dart';
import '../data/params/auction_params.dart';
import '../data/repo/my_sales_repo.dart';
import 'my_sales_state.dart';

class MySalesCubit extends Cubit<MySalesState> {
  MySalesCubit() : super(const MySalesInitial());

//---------------------------------VARIABLES----------------------------------//
  MySalesDisplayTypes displayType = MySalesDisplayTypes.list;
  List<AuctionEntity>? auctions;
  List<AuctionEntity>? searchResults;
  String currentSearchQuery = '';

//---------------------------------FUNCTIONS----------------------------------//
  void updateOrToggleDisplayType({MySalesDisplayTypes? type}) {
    if (type != null) {
      displayType = type;
    } else {
      displayType = displayType == MySalesDisplayTypes.list
          ? MySalesDisplayTypes.grid
          : MySalesDisplayTypes.list;
    }
    
    // Emit display type change while preserving current data state
    emit(MySalesDisplayTypeChanged(displayType: displayType));
    
    // Re-emit the current data state to maintain data visibility
    if (currentSearchQuery.isNotEmpty && searchResults != null) {
      if (searchResults!.isEmpty) {
        emit(const MySalesSearchEmpty());
      } else {
        emit(MySalesSearchSuccess(searchResults: searchResults!));
      }
    } else if (auctions != null) {
      if (auctions!.isEmpty) {
        emit(const MySalesInitial());
      } else {
        emit(MySalesSuccess(auctions: auctions!));
      }
    }
  }

  Future<void> getAuctions() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const MySalesLoading());

    final response = await MySalesRepo.getAuctions(const AuctionParams());

    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      emit(MySalesError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      auctions = success;
      emit(MySalesSuccess(auctions: auctions!));
    });
  }

  Future<void> searchAuctions(String query) async {
    currentSearchQuery = query;
    emit(const MySalesSearchLoading());

    final params = AuctionParams(query: query);
    final response = await MySalesRepo.getAuctions(params);

    response.fold((failure) {
      emit(MySalesSearchError(failure));
    }, (success) {
      searchResults = success;
      if (success.isEmpty) {
        emit(const MySalesSearchEmpty());
      } else {
        emit(MySalesSearchSuccess(searchResults: success));
      }
    });
  }

  void clearSearch() {
    currentSearchQuery = '';
    searchResults = null;
    // Emit the original data state
    if (auctions != null && auctions!.isNotEmpty) {
      emit(MySalesSuccess(auctions: auctions!));
    } else {
      emit(const MySalesInitial());
    }
  }

}
