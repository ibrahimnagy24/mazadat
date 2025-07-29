import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../data/entity/district_entity.dart';
import '../data/model/districts_model.dart';
import '../data/repo/districts_repo.dart';
part 'district_state.dart';

class DistrictsCubit extends Cubit<DistrictState> {
  DistrictsCubit() : super(DistrictStart()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//
  late ScrollController controller;
  late SearchEngine _engine;
  List<DistrictEntity>? model;

  //---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        districtsStatesHandled(_engine);
      }
    });
  }

//---------------------------------REQUEST----------------------------------//

  Future<void> districtsStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(DistrictLoading());
    } else {
      emit(DistrictSuccess(districts: model!, isLoading: true));
    }

    final response = await DistrictsRepo.getDistricts(_engine);
    response.fold((failure) {
      return emit(DistrictError(failure));
    }, (success) {
      DistrictsModel? res = DistrictsModel.fromJson(success.data);

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
        return emit(DistrictSuccess(districts: model!, isLoading: false));
      } else {
        return emit(DistrictEmpty());
      }
    });
  }
}
