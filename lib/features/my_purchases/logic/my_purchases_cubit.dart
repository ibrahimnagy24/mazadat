import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../data/entity/shipment_entity.dart';
import '../data/enum/display_types.dart';
import '../data/params/shipment_params.dart';
import '../data/repo/my_purchases_repo.dart';
import 'my_purchases_state.dart';

class MyPurchasesCubit extends Cubit<MyPurchasesState> {
  MyPurchasesCubit() : super(const MyPurchasesInitial());

//---------------------------------VARIABLES----------------------------------//
  MyPurchasesDisplayTypes displayType = MyPurchasesDisplayTypes.list;
  List<ShipmentEntity>? shipments;
  List<ShipmentEntity>? searchResults;
  String currentSearchQuery = '';

//---------------------------------FUNCTIONS----------------------------------//
  void updateOrToggleDisplayType({MyPurchasesDisplayTypes? type}) {
    if (type != null) {
      displayType = type;
    } else {
      displayType = displayType == MyPurchasesDisplayTypes.list
          ? MyPurchasesDisplayTypes.grid
          : MyPurchasesDisplayTypes.list;
    }
    
    // Emit display type change while preserving current data state
    emit(MyPurchasesDisplayTypeChanged(displayType: displayType));
    
    // Re-emit the current data state to maintain data visibility
    if (currentSearchQuery.isNotEmpty && searchResults != null) {
      if (searchResults!.isEmpty) {
        emit(const MyPurchasesSearchEmpty());
      } else {
        emit(MyPurchasesSearchSuccess(searchResults: searchResults!));
      }
    } else if (shipments != null) {
      if (shipments!.isEmpty) {
        emit(const MyPurchasesInitial());
      } else {
        emit(MyPurchasesSuccess(shipments: shipments!));
      }
    }
  }

  Future<void> getShipments() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const MyPurchasesLoading());

    final response = await MyPurchasesRepo.getShipments(const ShipmentParams());

    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      emit(MyPurchasesError(failure));
    }, (success) {
      CustomNavigator.context.loaderOverlay.hide();
      shipments = success;
      emit(MyPurchasesSuccess(shipments: shipments!));
    });
  }

  Future<void> searchShipments(String query) async {
    currentSearchQuery = query;
    emit(const MyPurchasesSearchLoading());

    final params = ShipmentParams(query: query);
    final response = await MyPurchasesRepo.getShipments(params);

    response.fold((failure) {
      emit(MyPurchasesSearchError(failure));
    }, (success) {
      searchResults = success;
      if (success.isEmpty) {
        emit(const MyPurchasesSearchEmpty());
      } else {
        emit(MyPurchasesSearchSuccess(searchResults: success));
      }
    });
  }

  void clearSearch() {
    currentSearchQuery = '';
    searchResults = null;
    // Emit the original data state
    if (shipments != null && shipments!.isNotEmpty) {
      emit(MyPurchasesSuccess(shipments: shipments!));
    } else {
      emit(const MyPurchasesInitial());
    }
  }

}
