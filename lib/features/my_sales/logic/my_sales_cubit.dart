import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../../auctions/data/entity/auction_entity.dart';
import '../../auctions/data/model/auctions_model.dart';
import '../data/repo/my_sales_repo.dart';
import 'my_sales_state.dart';

class MySalesCubit extends Cubit<MySalesState> {
  MySalesCubit() : super(const MySalesInitial()) {
    controller = ScrollController();
    keywordTEC = TextEditingController();
    customScroll(controller);
    updateListing(true);

  }
//---------------------------------VARIABLES----------------------------------//

  final listing = BehaviorSubject<bool>();
  Function(bool) get updateListing => listing.sink.add;
  Stream<bool> get listingStream => listing.stream.asBroadcastStream();

  late ScrollController controller;
  late SearchEngine _engine;
  List<AuctionEntity>? model;

  late TextEditingController keywordTEC;

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        mySalesStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> mySalesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const MySalesLoading());
    } else {
      emit(MySalesSuccess(auctions: model!, isLoading: true));
    }


    _engine.query = {
      'keyword':keywordTEC.text.trim()
    };
    final response = await MySalesRepo.mySales(_engine);
    response.fold((failure) {
      return emit(MySalesError(failure));
    }, (success) {
      AuctionsModel? res = AuctionsModel.fromJson(success.data);

      if (_engine.currentPage == -1) {
        model?.clear();
      }

      if (res.content != null && res.content!.isNotEmpty) {
        for (var item in res.content!) {
          model?.removeWhere((e) => e.id == item.id);
          model?.add(item);
        }
      }
      _engine.maxPages = res.pageable?.maxPages ?? 1;
      _engine.updateCurrentPage(res.pageable?.currentPage ?? 0);

      if (model != null && model!.isNotEmpty) {
        return emit(MySalesSuccess(auctions: model!, isLoading: false));
      } else {
        return emit(const MySalesEmpty());
      }
    });
  }
}
