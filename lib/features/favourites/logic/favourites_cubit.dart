import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../../auctions/data/entity/auction_entity.dart';
import '../../auctions/data/model/auctions_model.dart';
import '../data/params/toggle_favourites_params.dart';
import '../data/repo/favourites_repo.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(const FavouritesInitial()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//

  late ScrollController controller;
  late SearchEngine _engine;
  List<AuctionEntity>? model;

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
      // AuctionsModel? res = AuctionsModel.fromJson(success.data);

      // if (_engine.currentPage == -1) {
      //   model?.clear();
      // }

      // if (res.content != null && res.content!.isNotEmpty) {
      //   for (var item in res.content!) {
      //     model?.removeWhere((e) => e.id == item.id);
      //     model?.add(item);
      //   }
      // }
      // _engine.maxPages = res.pageable?.maxPages ?? 1;
      // _engine.updateCurrentPage(res.pageable?.currentPage ?? 0);

      if (model != null && model!.isNotEmpty) {
        return emit(FavouritesSuccess(auctions: model!, isLoading: false));
      } else {
        return emit(const FavouritesEmpty());
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
        model?.removeWhere((e) => e.id == params.id);

        if (model != null && model!.isNotEmpty) {
          return emit(FavouritesSuccess(auctions: model!, isLoading: false));
        } else {
          return emit(const FavouritesEmpty());
        }
      });
    } catch (e) {
      CustomNavigator.pop();
      return showErrorSnackBar(e.toString());
    }
  }
}
