import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/utility.dart';
import '../data/params/delete_account_params.dart';
import '../data/repository/delete_account_repo.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//---------------------------------FUNCTIONS----------------------------------//

  @override
  Future<void> close() {
    password.dispose();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> deleteAccountStatesHandled() async {
    emit(const DeleteAccountLoading());
    final response = await DeleteAccountRepo.deleteAccount(
      DeleteAccountParams(
        password: password.text,
      ),
    );
    response.fold((failure) {
      return emit(DeleteAccountError(failure));
    }, (success) async {
      if (success.statusCode == 200) {
        await Utility.logout();
        return emit(const DeleteAccountSuccess());
      } else {
        return emit(
          DeleteAccountError(
            ErrorEntity(
              statusCode: success.statusCode ?? 404,
              message: success.data?['message'],
              errors: const [],
            ),
          ),
        );
      }
    });
  }
}
