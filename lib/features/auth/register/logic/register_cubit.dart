import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../../../core/app_core.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../selectors/age/data/entity/age_entity.dart';
import '../../../selectors/city/data/entity/city_entity.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool agreePolicyAndConditions = false;

//---------------------------------FUNCTIONS----------------------------------//

  agreePolicyAndConditionsFunction() {
    agreePolicyAndConditions = !agreePolicyAndConditions;
    emit(AgreePolicyAndConditionsState());
  }

  final city = BehaviorSubject<CityEntity?>();
  Function(CityEntity?) get updateCity => city.sink.add;
  Stream<CityEntity?> get cityStream => city.stream.asBroadcastStream();

  final age = BehaviorSubject<AgeEntity?>();
  Function(AgeEntity?) get updateAge => age.sink.add;
  Stream<AgeEntity?> get ageStream => age.stream.asBroadcastStream();

  final gender = BehaviorSubject<GenderTypes?>();
  Function(GenderTypes?) get updateGender => gender.sink.add;
  Stream<GenderTypes?> get genderStream => gender.stream.asBroadcastStream();

  final step = BehaviorSubject<int>();
  Function(int) get updateStep => step.sink.add;
  Stream<int> get stepStream => step.stream.asBroadcastStream();

  bool isRegisterValidate() {
    if (!agreePolicyAndConditions) {
      showErrorSnackBar('AppStrings.pleaseCheckTermsAndConditions.tr');
      return false;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
    // if (!fromChooseCategoryScreen) {
    // } else {
    //   if (choosenCategories.isEmpty) {
    //     showErrorSnackBar('please choose atleast one cat');
    //     return false;
    //   } else {
    //     return true;
    //   }
    // }
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
        categories: const [],
        firstName: firstName.text,
        lastName: lastName.text,
        phone: phone.text,
      ),
    );
    response.fold((failure) {
      return emit(RegisterError(failure));
    }, (success) async {
      return emit(RegisterSucess(success));
    });
  }
}
