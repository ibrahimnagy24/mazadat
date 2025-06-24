import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums/enums.dart';
import '../data/params/reset_password_params.dart';
import '../data/repo/reset_password_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//---------------------------------FUNCTIONS----------------------------------//

  @override
  Future<void> close() {
    phone.dispose();
    return super.close();
  }

  bool isResetValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> resetPasswordStatesHandled() async {
    emit(const ResetPasswordLoading());
    final response = await ResetPasswordRepo.resetPassword(ResetPasswordParams(
      phone: phone.text,
      countryCode: '966',
      fromScreenEnum: VerifyCodeFromScreen.fromForgetPassword,
    ));
    response.fold((failure) {
      return emit(ResetPasswordError(failure));
    }, (success) async {
      return emit(ResetPasswordSucess(success));
    });
  }
}
