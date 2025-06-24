import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/cache/shared_helper.dart';
import '../data/params/login_params.dart';
import '../data/repository/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool rememberMe = false;

//---------------------------------FUNCTIONS----------------------------------//
  void toggleRememberMeFunction() {
    rememberMe = !rememberMe;
    emit(RememberMeStates());
  }

  @override
  Future<void> close() {
    phone.dispose();
    password.dispose();
    return super.close();
  }

  bool isLoginValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> loginStatesHandled() async {
    emit(const LoginLoading());
    final response = await LoginRepo.login(
      LoginParams(
        phone: phone.text,
        password: password.text,
      ),
    );
    response.fold((failure) {
      return emit(LoginError(failure));
    }, (success) async {
      await SharedHelper.sharedHelper?.cacheLoginData(success);
      return emit(LoginSucess(success));
    });
  }
}
