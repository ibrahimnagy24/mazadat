import '../../../core/shared/entity/error_entity.dart';
import '../data/model/addresses_model.dart';

sealed class AddressesState {
  const AddressesState();
}

final class AddressesInitial extends AddressesState {
  const AddressesInitial();
}

final class AddressesEmpty extends AddressesState {
  const AddressesEmpty();
}

class AddressesLoading extends AddressesState {
  const AddressesLoading();
}

class AddressesSuccess extends AddressesState {
  final List<AddressModel> addresses;
  final bool isLoading;
  const AddressesSuccess({required this.addresses, this.isLoading = false});
}

class AddressesError extends AddressesState {
  final ErrorEntity error;
  const AddressesError(this.error);
}
