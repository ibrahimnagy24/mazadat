import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../data/entity/bundle_entity.dart';
import '../data/model/bundles_model.dart';
import '../data/repo/bundles_repo.dart';
import 'bundles_state.dart';

class BundlesCubit extends Cubit<BundlesState> {
  BundlesCubit() : super(const BundlesInitial()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//

  late ScrollController controller;
  late SearchEngine _engine;
  List<BundleEntity>? model;

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        bundlesStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> bundlesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const BundlesLoading());
    } else {
      emit(BundlesSuccess(bundles: model!, isLoading: true));
    }

    final response = await BundlesRepo.bundles(_engine);
    response.fold((failure) {
      return emit(BundlesError(failure));
    }, (success) {
      BundlesModel? res = BundlesModel.fromJson(success.data);

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
        return emit(BundlesSuccess(bundles: model!, isLoading: false));
      } else {
        return emit(const BundlesEmpty());
      }
    });
  }
}
