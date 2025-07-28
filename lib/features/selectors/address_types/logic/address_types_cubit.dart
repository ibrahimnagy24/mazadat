import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../data/entity/address_type_entity.dart';
import '../data/model/address_type_model.dart';
import '../data/repo/address_types_repo.dart';
part 'address_types_state.dart';



class AddressTypesCubit extends Cubit<AddressTypesState> {
  AddressTypesCubit() : super(AddressTypesStart()) {
    controller = ScrollController();
    customScroll(controller);
  }
//---------------------------------VARIABLES----------------------------------//
  late ScrollController controller;
  late SearchEngine _engine;
  List<AddressTypeEntity>? model;

  //---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        addressTypesStatesHandled(_engine);
      }
    });
  }

//---------------------------------REQUEST----------------------------------//

  Future<void> addressTypesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(AddressTypesLoading());
    } else {
      emit(AddressTypesDone(addressTypes: model!, isLoading: true));
    }

    final response = await AddressTypesRepo.getAddressTypes(_engine);
    response.fold((failure) {
      return emit(AddressTypesError(failure));
    }, (success) {
      AddressTypesModel? res = AddressTypesModel.fromJson(success.data);

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
        emit(AddressTypesDone(addressTypes: model!, isLoading: false));
      } else {
        return emit(AddressTypesEmpty());
      }
    });
  }
}
