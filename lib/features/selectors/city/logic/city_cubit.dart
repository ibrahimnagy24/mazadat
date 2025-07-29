import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../data/entity/city_entity.dart';
import '../data/model/city_model.dart';
import '../data/repo/cities_repo.dart';
part 'city_state.dart';



class CityCubit extends Cubit<CityState> {
  CityCubit() : super(CityStart()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//
  late ScrollController controller;
  late SearchEngine _engine;
  List<CityEntity>? model;

  //---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        citiesStatesHandled(_engine);
      }
    });
  }

//---------------------------------REQUEST----------------------------------//

  Future<void> citiesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(CityLoading());
    } else {
      emit(CityDone(cities: model!, isLoading: true));
    }

    final response = await CitiesRepo.getCities(_engine);
    response.fold((failure) {
      return emit(CityError(failure));
    }, (success) {
      CitiesModel? res = CitiesModel.fromJson(success.data);

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
        emit(CityDone(cities: model!, isLoading: false));
      } else {
        return emit(CityEmpty());
      }
    });
  }
}
