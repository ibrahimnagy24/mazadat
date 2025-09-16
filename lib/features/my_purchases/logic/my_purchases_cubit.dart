import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../data/entity/my_purchase_content_entity.dart';
import '../data/model/my_purchases_model.dart';
import '../data/repo/my_purchases_repo.dart';
import 'my_purchases_state.dart';

class MyPurchasesCubit extends Cubit<MyPurchasesState> {
  MyPurchasesCubit() : super(const MyPurchasesInitial()) {
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
  List<MyPurchaseContentEntity>? model;

  late TextEditingController keywordTEC;

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        myPurchasesStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> myPurchasesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const MyPurchasesLoading());
    } else {
      emit(MyPurchasesSuccess(purchases: model!, isLoading: true));
    }

    _engine.query = {'keyword': keywordTEC.text.trim()};
    final response = await MyPurchasesRepo.myPurchases(_engine);
    response.fold((failure) {
      return emit(MyPurchasesError(failure));
    }, (success) {
      MyPurchasesModel res = success;

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
        return emit(MyPurchasesSuccess(purchases: model!, isLoading: false));
      } else {
        return emit(const MyPurchasesEmpty());
      }
    });
  }
}
