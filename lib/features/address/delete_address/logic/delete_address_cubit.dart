import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/delete_address_repo.dart';
import 'delete_address_state.dart';

class DeleteAddressCubit extends Cubit<DeleteAddressState> {
  DeleteAddressCubit() : super(DeleteAddressInitial());

//----------------------------------REQUEST-----------------------------------//
  Future<void> deleteAddressStatesHandled({required int id}) async {
    emit(const DeleteAddressLoading());
    final response = await DeleteAddressRepo.deleteAddress(id);
    response.fold((failure) {
      return emit(DeleteAddressError(failure));
    }, (success) async {
      return emit(const DeleteAddressSuccess());
    });
  }
}
