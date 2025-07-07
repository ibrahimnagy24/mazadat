import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../selectors/age/data/entity/age_entity.dart';
import '../../selectors/city/data/entity/city_entity.dart';
import '../../user/data/entity/user_entity.dart';
import '../../user/logic/user_cubit.dart';
import '../data/params/edit_profile_params.dart';
import '../data/repository/edit_profile_repo.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial()) {
    onStart();
  }
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//---------------------------------FUNCTIONS----------------------------------//

  final city = BehaviorSubject<CityEntity?>();
  Function(CityEntity?) get updateCity => city.sink.add;
  Stream<CityEntity?> get cityStream => city.stream.asBroadcastStream();

  final age = BehaviorSubject<AgeEntity?>();
  Function(AgeEntity?) get updateAge => age.sink.add;
  Stream<AgeEntity?> get ageStream => age.stream.asBroadcastStream();

  final gender = BehaviorSubject<GenderTypes?>();
  Function(GenderTypes?) get updateGender => gender.sink.add;
  Stream<GenderTypes?> get genderStream => gender.stream.asBroadcastStream();

  bool isRegisterValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
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
    gender.close();
    city.close();
    age.close();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> editProfileStatesHandled() async {
    emit(const EditProfileLoading());
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;
    final response = await EditProfileRepo.editProfile(
      EditProfileParams(
        email: email.text,
        firstName: firstName.text,
        lastName: lastName.text,
        city: city.valueOrNull?.id,
        age: age.valueOrNull?.id,
        gender: gender.valueOrNull,
        phone: user?.phone ?? '',
      ),
    );
    response.fold((failure) {
      return emit(EditProfileError(failure));
    }, (success) async {
      return emit(EditProfileSuccess(success));
    });
  }

  Future<void> onStart() async {
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;
    firstName.text = user?.firstName.trim() ?? '';
    lastName.text = user?.lastName.trim() ?? '';
    email.text = user?.email.trim() ?? '';
    phone.text = user?.phone.trim() ?? '';
    updateAge(user?.age);
    updateGender(user?.gender);
    updateCity(user?.city);
    return emit(EditProfileInitial());
  }
}
