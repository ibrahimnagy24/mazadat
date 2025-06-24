import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/params/change_password_params.dart';
import '../data/params/change_password_route_params.dart';
import '../data/repo/change_password_repo.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ChangePasswordRouteParams routeParams;
//---------------------------------FUNCTIONS----------------------------------//
  void init(ChangePasswordRouteParams params) {
    routeParams = params;
  }

  @override
  Future<void> close() {
    newPassword.dispose();
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
  Future<void> changePasswordStatesHandled() async {
    emit(const ChangePasswordLoading());
    final response = await ChangePasswordRepo.changePassword(
      ChangePasswordParams(
        comfirmPassword: newPassword.text,
        newPassword: confirmPassword.text,
        email: routeParams.email,
      ),
    );
    response.fold((failure) {
      return emit(ChangePasswordError(failure));
    }, (success) async {
      // await saveToken(success.tokenEntity);
      return emit(ChangePasswordSucess(success));
    });
  }
}
