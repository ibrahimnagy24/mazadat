import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums/enums.dart';
import '../data/params/forget_password_params.dart';
import '../data/repo/forget_password_repo.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
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
  Future<void> forgetPasswordStatesHandled() async {
    emit(const ForgetPasswordLoading());
    final response = await ForgetPasswordRepo.forgetPassword(ForgetPasswordParams(
      phone: phone.text,
      countryCode: '966',
      fromScreenEnum: VerifyCodeFromScreen.fromForgetPassword,
    ));
    response.fold((failure) {
      return emit(ForgetPasswordError(failure));
    }, (success) async {
      return emit(ForgetPasswordSuccess(success));
    });
  }
}
