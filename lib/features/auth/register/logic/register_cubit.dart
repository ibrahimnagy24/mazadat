import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../selectors/age/data/entity/age_entity.dart';
import '../../../address/city/data/entity/city_entity.dart';
import '../data/params/register_params.dart';
import '../data/repository/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    updateStep(0);
  }
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  AgeEntity? ageController;
  GenderTypes? genderController;
  CityEntity? cityEntity;
  final GlobalKey<FormState> stepOneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stepTwoFormKey = GlobalKey<FormState>();
  bool agreePolicyAndConditions = false;

//---------------------------------FUNCTIONS----------------------------------//

  agreePolicyAndConditionsFunction() {
    agreePolicyAndConditions = !agreePolicyAndConditions;
    emit(AgreePolicyAndConditionsState());
  }

  int _currentStep = 0;
  int get currentStep => _currentStep;

  void updateStep(int step) {
    _currentStep = step;
    emit(RegisterStepChanged(step));
  }

  void rebuildInputs() {
    emit(RebuildInputs());
  }

  bool isStepOneValid() {
    if (stepOneFormKey.currentState!.validate()) {
      stepOneFormKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  bool isAgreePolicyAndConditionsValid() {
    if (!agreePolicyAndConditions) {
      return false;
    }
    return true;
  }

  bool isStepTwoValid() {
    if (stepTwoFormKey.currentState!.validate()) {
      stepTwoFormKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> registerStatesHandled() async {
    emit(const RegisterLoading());
    final response = await RegisterRepo.register(
      RegisterParams(
        email: email.text,
        password: password.text,
        firstName: firstName.text,
        lastName: lastName.text,
        phone: phone.text,
        city: cityEntity?.id,
        age: ageController?.id,
        gender: genderController,
      ),
    );
    response.fold((failure) {
      return emit(RegisterError(failure));
    }, (success) async {
      return emit(RegisterSucess(success));
    });
  }
}
