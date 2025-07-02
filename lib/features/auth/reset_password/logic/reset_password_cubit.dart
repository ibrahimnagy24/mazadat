import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/params/reset_password_params.dart';
import '../data/params/reset_password_route_params.dart';
import '../data/repo/reset_password_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ResetPasswordRouteParams routeParams;
//---------------------------------FUNCTIONS----------------------------------//
  void init(ResetPasswordRouteParams params) {
    routeParams = params;
  }

  @override
  Future<void> close() {
    password.dispose();
    confirmPassword.dispose();
    return super.close();
  }

  bool isNewPasswordValid() {
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
    final response = await ResetPasswordRepo.resetPassword(
      ResetPasswordParams(
        password: password.text,
        otp: routeParams.otp,
        phone: routeParams.phone,
      ),
    );
    response.fold((failure) {
      return emit(ResetPasswordError(failure));
    }, (success) async {
      // await saveToken(success.tokenEntity);
      return emit(ResetPasswordSuccess(success));
    });
  }
}
