import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/services/pagination/pagination_service.dart';
import '../../../address/addresses/data/model/addresses_model.dart';
import '../../../address/addresses/data/repo/addresses_repo.dart';
import '../data/params/checkout_address_params.dart';
import '../data/params/checkout_address_route_params.dart';
import '../data/repo/check_out_repo.dart';
import 'checkout_address_state.dart';

class CheckoutAddressCubit extends Cubit<CheckoutAddressState> {
  CheckoutAddressCubit() : super(const CheckoutAddressInitial());

//---------------------------------VARIABLES----------------------------------//
  List<AddressModel>? _addresses;
  AddressModel? _selectedAddress;
  late CheckoutAddressRouteParams routeParams;
//---------------------------------FUNCTIONS----------------------------------//
  void init(CheckoutAddressRouteParams routeParams) {
    this.routeParams = routeParams;
  }

  /// Get the currently selected address
  AddressModel? get selectedAddress => _selectedAddress;

  /// Get all addresses
  List<AddressModel>? get addresses => _addresses;

  /// Select an address for checkout
  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    if (_addresses != null && _addresses!.isNotEmpty) {
      emit(CheckoutAddressSelected(
        addresses: _addresses!,
        selectedAddress: address,
      ));
    }
  }

  /// Clear the selected address
  void clearSelectedAddress() {
    _selectedAddress = null;
    if (_addresses != null && _addresses!.isNotEmpty) {
      emit(CheckoutAddressLoaded(addresses: _addresses!));
    }
  }

//----------------------------------REQUEST-----------------------------------//

  /// Fetch user addresses for checkout
  Future<void> fetchAddresses() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const CheckoutAddressLoading());

    final searchEngine = SearchEngine(currentPage: -1);
    final response = await AddressesRepo.getAddresses(searchEngine);

    response.fold(
      (failure) {
        CustomNavigator.context.loaderOverlay.hide();
        emit(CheckoutAddressError(failure));
      },
      (success) {
        CustomNavigator.context.loaderOverlay.hide();
        final addressesModel = AddressesModel.fromJson(success.data);
        _addresses = addressesModel.content ?? [];

        if (_addresses != null && _addresses!.isNotEmpty) {
          // Only auto-select if there's a default address
          final defaultAddress = _addresses!
              .where(
                (address) => address.isDefault == true,
              )
              .firstOrNull;

          if (defaultAddress != null) {
            // Default address exists, auto-select it
            _selectedAddress = defaultAddress;
            emit(CheckoutAddressSelected(
              addresses: _addresses!,
              selectedAddress: _selectedAddress!,
            ));
          } else {
            // No default address, don't select any
            _selectedAddress = null;
            emit(CheckoutAddressLoaded(addresses: _addresses!));
          }
        } else {
          emit(const CheckoutAddressEmpty());
        }
      },
    );
  }

  Future<void> setDefaultAddress() async {
    if (_selectedAddress == null || _selectedAddress!.id == null) return;
    CustomNavigator.context.loaderOverlay.show();
    emit(SetDefaultAddressLoading());
    final response = await CheckOutRepo.setDefaultAddress(
        CheckoutAddressParams(addressId: _selectedAddress!.id!));
    response.fold(
      (failure) {
        CustomNavigator.context.loaderOverlay.hide();
        emit(SetDefaultAddressError(failure));
      },
      (success) {
        CustomNavigator.context.loaderOverlay.hide();
        emit(SetDefaultAddressSuccess(success));
      },
    );
  }
//---------------------------------HELPERS------------------------------------//

  /// Check if an address is selected
  bool isAddressSelected(AddressModel address) {
    return _selectedAddress?.id == address.id;
  }
}
