import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums/enums.dart';
import '../data/params/change_phone_number_params.dart';
import '../data/params/change_phone_number_route_params.dart';
import '../data/repo/change_phone_number_repo.dart';
import 'change_phone_number_state.dart';

class ChangePhoneNumberCubit extends Cubit<ChangePhoneNumberState> {
  ChangePhoneNumberCubit() : super(ChangePhoneNumberInitial());
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ChangePhoneNumberRouteParams params;
//---------------------------------FUNCTIONS----------------------------------//
  void init(ChangePhoneNumberRouteParams params) {
    this.params = params;
  }

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
  Future<void> changePhoneNumberStatesHandled() async {
    emit(const ChangePhoneNumberLoading());
    final response =
        await ChangePhoneNumberRepo.changePhoneNumber(ChangePhoneNumberParams(
      oldPhone: params.oldPhone,
      phone: phone.text,
      countryCode: '966',
      fromScreenEnum: VerifyCodeFromScreen.fromChangePhoneNumber,
    ));
    response.fold((failure) {
      return emit(ChangePhoneNumberError(failure));
    }, (success) async {
      return emit(ChangePHoneNumberSuccess(success));
    });
  }
}
