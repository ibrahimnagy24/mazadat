import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../../core/services/cache/shared_helper.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../forget_password/data/params/forget_password_params.dart';
import '../data/params/send_code_params.dart';
import '../data/params/verify_code_params.dart';
import '../data/params/verify_code_route_params.dart';
import '../data/repo/verify_code_repo.dart';
import 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController code = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ForgetPasswordParams resetPasswordParams;
  late final VerifyCodeRouteParams verifyCodeRouteParams;
  Timer? _timer;
  int timerDuration = 60;
  bool isResendCodeButtonActive = false;

//---------------------------------FUNCTIONS----------------------------------//
  void init(VerifyCodeRouteParams params) {
    verifyCodeRouteParams = params;
  }

  void setResetPasswordParams() {
    resetPasswordParams = ForgetPasswordParams(
      phone: verifyCodeRouteParams.phone,
      fromScreenEnum: verifyCodeRouteParams.fromScreenEnum,
      countryCode: verifyCodeRouteParams.countryCode,
    );
  }

  void startTimer() {
    _timer?.cancel();
    isResendCodeButtonActive = false;
    timerDuration = 60;

    emit(TimerChanged());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerDuration > 0) {
        timerDuration--;
        emit(TimerChanged());
      } else {
        _timer?.cancel();
        isResendCodeButtonActive = true;
        emit(TimerChanged());
      }
    });
  }

  String getTitle() {
    switch (resetPasswordParams.fromScreenEnum) {
      case VerifyCodeFromScreen.fromForgetPassword:
        return AppStrings.verificationCode.tr;
      case VerifyCodeFromScreen.fromLogin:
        return AppStrings.confirmMobileNumber.tr;
      case VerifyCodeFromScreen.fromRegister:
        return AppStrings.confirmMobileNumber.tr;
      case VerifyCodeFromScreen.fromChangePhoneNumber:
        return AppStrings.confirmMobileNumber.tr;
    }
  }

  @override
  Future<void> close() {
    code.dispose();
    _timer?.cancel();
    return super.close();
  }

  bool isResetValidate() {
    if (code.text.length < 4) {
      showErrorSnackBar(AppStrings.pleaseEnterValidCode.tr);
      return false;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> verifyCodeStatesHandled() async {
    emit(const VerifyCodeLoading());
    final response = await VerifyCodeRepo.verifyCode(
      VerifyCodeParams(
        oldPhone: verifyCodeRouteParams.oldPhone,
        phone: verifyCodeRouteParams.phone,
        countryCode: verifyCodeRouteParams.countryCode,
        code: code.text,
        verifyCodeFromScreen: verifyCodeRouteParams.fromScreenEnum,
      ),
    );
    response.fold((failure) {
      return emit(VerifyCodeError(failure));
    }, (success) async {
      switch (resetPasswordParams.fromScreenEnum) {
        case VerifyCodeFromScreen.fromForgetPassword:
          break;
        case VerifyCodeFromScreen.fromLogin:
          await SharedHelper.sharedHelper?.cacheLoginData(success);
          break;
        case VerifyCodeFromScreen.fromRegister:
          await SharedHelper.sharedHelper?.cacheLoginData(success);
          break;

        case VerifyCodeFromScreen.fromChangePhoneNumber:
          await SharedHelper.sharedHelper?.cacheLoginData(success);
          break;
      }

      return emit(VerifyCodeSuccess(success));
    });
  }

  Future<void> resendVerifyCodeStatesHandled() async {
    emit(const ResendVerifyCodeLoading());
    final response = await VerifyCodeRepo.sendVerifyCode(
      SendCodeParams(
        phone: verifyCodeRouteParams.phone,
        countryCode: verifyCodeRouteParams.countryCode,
      ),
    );
    response.fold((failure) {
      return emit(ResendVerifyCodeError(failure));
    }, (success) async {
      return emit(ResendVerifyCodeSucess(success));
    });
  }
}
