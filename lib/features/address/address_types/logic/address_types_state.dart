part of 'address_types_cubit.dart';

sealed class AddressTypesState {
  const AddressTypesState();
}

final class AddressTypesStart extends AddressTypesState {}

final class AddressTypesLoading extends AddressTypesState {}
final class AddressTypesEmpty extends AddressTypesState {}

final class AddressTypesDone extends AddressTypesState {
  const AddressTypesDone({required this.addressTypes,this.isLoading = false});
  final List<AddressTypeEntity> addressTypes;
  final bool isLoading;
}

final class AddressTypesError extends AddressTypesState {
  const AddressTypesError(this.error);
  final ErrorEntity error;
}
