import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/params/change_password_params.dart';
import '../data/repo/reset_password_repo.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController password = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//---------------------------------FUNCTIONS----------------------------------//

  @override
  Future<void> close() {
    password.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> resetPasswordStatesHandled() async {
    emit(const ResetPasswordLoading());
    final response = await ChangePasswordRepo.changePassword(
      ChangePasswordParams(
        newPassword: newPassword.text,
        oldPassword: password.text,
      ),
    );
    response.fold((failure) {
      return emit(ChangePasswordError(failure));
    }, (success) async {
      return emit(ChangePasswordSuccess(success));
    });
  }
}
