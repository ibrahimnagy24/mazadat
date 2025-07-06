import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../../auctions/data/entity/auction_entity.dart';
import '../data/model/search_model.dart';
import '../data/params/filter_params.dart';
import '../data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial()) {
    updateFilter(FilterParams(keywordTEC: TextEditingController()));
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//

  resetFilter() {
    filter.valueOrNull?.keywordTEC?.clear();
    updateFilter(FilterParams());
    searchStatesHandled(SearchEngine());
  }

  late ScrollController controller;
  late SearchEngine _engine;
  List<AuctionEntity>? model;

  final filter = BehaviorSubject<FilterParams>();
  Function(FilterParams) get updateFilter => filter.sink.add;
  Stream<FilterParams> get filterStream => filter.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        searchStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> searchStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const SearchLoading());
    } else {
      emit(SearchSuccess(auctions: model!, isLoading: true));
    }

    _engine.query = filter.valueOrNull?.toJson();

    final response = await SearchRepo.search(params);
    response.fold((failure) {
      return emit(SearchError(failure));
    }, (success) {
      SearchModel? res = SearchModel.fromJson(success.data);

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
        return emit(SearchSuccess(auctions: model!, isLoading: false));
      } else {
        return emit(const SearchEmpty());
      }
    });
  }
}
