import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../data/entity/auction_entity.dart';
import '../data/repo/auction_repo.dart';
import 'auctions_state.dart';

class AuctionsCubit extends Cubit<AuctionsState> {
  AuctionsCubit() : super(const AuctionsInitial()) {
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
        auctionStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> auctionStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const AuctionsLoading());
    } else {
      emit(AuctionsSuccess(auctions: model!, isLoading: true));
    }

    final response = await AuctionRepo.auction(params);
    response.fold((failure) {
      return emit(AuctionsError(failure));
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
        return emit(AuctionsSuccess(auctions: model!, isLoading: false));
      } else {
        return emit(const AuctionsEmpty());
      }
    });
  }
}
