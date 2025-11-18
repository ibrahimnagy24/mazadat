import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_core.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../../../auctions/data/entity/auction_entity.dart';
import '../data/model/search_result_model.dart';
import '../data/repo/search_result_repo.dart';
import 'search_state.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  SearchResultCubit() : super(const SearchResultInitial()) {
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
        searchResultStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> searchResultStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const SearchResultLoading());
    } else {
      emit(SearchResultSuccess(auctions: model!, isLoading: true));
    }

    final response = await SearchResultRepo.searchResult(params);
    response.fold((failure) {
      return emit(SearchResultError(failure));
    }, (success) {
      SearchResultModel? res = SearchResultModel.fromJson(success.data);

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
        return emit(SearchResultSuccess(auctions: model!, isLoading: false));
      } else {
        return emit(const SearchResultEmpty());
      }
    });
  }

  Future<void> onDeleteItem(id) async {
    try {
      loadingDialog();

      final response = await SearchResultRepo.deleteSearch(id);
      CustomNavigator.pop();

      response.fold((fail) {
        return showErrorSnackBar(fail.message);
      }, (success) {
        showSuccessSnackBar(success.data['MESSAGE']);
        model?.removeWhere((e) => e.searchId == id);

        if (model != null && model!.isNotEmpty) {
          return emit(SearchResultSuccess(auctions: model!, isLoading: false));
        } else {
          return emit(const SearchResultEmpty());
        }
      });
    } catch (e) {
      CustomNavigator.pop();
      return showErrorSnackBar(e.toString());
    }
  }

  Future<void> onDeleteAll() async {
    try {
      loadingDialog();

      final response = await SearchResultRepo.deleteAllSearch();
      CustomNavigator.pop();

      response.fold((fail) {
        return showErrorSnackBar(fail.message);
      }, (success) {
        showSuccessSnackBar(success.data['MESSAGE']);
        model?.clear();

        if (model != null && model!.isNotEmpty) {
          return emit(SearchResultSuccess(auctions: model!, isLoading: false));
        } else {
          return emit(const SearchResultEmpty());
        }
      });
    } catch (e) {
      CustomNavigator.pop();
      return showErrorSnackBar(e.toString());
    }
  }
}
