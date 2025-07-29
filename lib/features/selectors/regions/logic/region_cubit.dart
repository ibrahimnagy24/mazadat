import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../data/entity/region_entity.dart';
import '../data/model/regions_model.dart';
import '../data/repo/regions_repo.dart';
part 'region_state.dart';

class RegionsCubit extends Cubit<RegionState> {
  RegionsCubit() : super(RegionStart()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//
  late ScrollController controller;
  late SearchEngine _engine;
  List<RegionEntity>? model;

  //---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        regionsStatesHandled(_engine);
      }
    });
  }

//---------------------------------REQUEST----------------------------------//

  Future<void> regionsStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(RegionLoading());
    } else {
      emit(RegionSuccess(regions: model!, isLoading: true));
    }

    final response = await RegionsRepo.getRegions(_engine);
    response.fold((failure) {
      return emit(RegionError(failure));
    }, (success) {
      RegionsModel? res = RegionsModel.fromJson(success.data);

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
        return emit(RegionSuccess(regions: model!, isLoading: false));
      } else {
        return emit(RegionEmpty());
      }
    });
  }
}
