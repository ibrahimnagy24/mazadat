import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../data/model/addresses_model.dart';
import '../data/repo/addresses_repo.dart';
import 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(const AddressesInitial()) {
    controller = ScrollController();
    customScroll(controller);
    updateListing(true);
  }
//---------------------------------VARIABLES----------------------------------//

  final listing = BehaviorSubject<bool>();
  Function(bool) get updateListing => listing.sink.add;
  Stream<bool> get listingStream => listing.stream.asBroadcastStream();

  late ScrollController controller;
  late SearchEngine _engine;
  List<AddressModel>? model;

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        addressesStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> addressesStatesHandled(SearchEngine params) async {
    CustomNavigator.context.loaderOverlay.show();
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const AddressesLoading());
    } else {
      emit(AddressesSuccess(addresses: model!, isLoading: true));
    }

    final response = await AddressesRepo.getAddresses(_engine);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(AddressesError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      AddressesModel? res = AddressesModel.fromJson(success.data);

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
        return emit(AddressesSuccess(addresses: model!, isLoading: false));
      } else {
        return emit(const AddressesEmpty());
      }
    });
  }
}
