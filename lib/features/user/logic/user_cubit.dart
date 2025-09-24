import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/services/cache/shared_helper.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../data/entity/user_entity.dart';
import '../repo/user_repo.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());
//---------------------------------VARIABLES----------------------------------//
  UserEntity? _userEntity;
//---------------------------------FUNCTIONS----------------------------------//
  UserEntity? get userEntity {
    return _userEntity ?? SharedHelper.sharedHelper?.getUser();
  }

  void _loginAsGuest({String? visitorName}) {
    final name = visitorName ?? 'visitor${Random().nextInt(1000)}';
    _userEntity = UserEntity(
      id: -1,
      gender: GenderTypes.male,
      userType: UserType.visitor,
      userStatus: UserStatus.active,
      email: '$name@Mazaadat.com',
      token: '',
      isVerified: false,
      allowNotification: false,
      phone: '500000000',
      completePhone: '966500000000',
      commericalNumber: '500000000',
      countryCode: '966',
      favoriteCategories: const [],
      firstName: 'Mazaadat',
      lastName: 'App',
    );
    mainAppBloc.setGlobalUserData = _userEntity;
    emit(UserDataSuccess(_userEntity!));
  }

  UserEntity? setUser(UserEntity user) {
    _userEntity = user;
    mainAppBloc.setGlobalUserData = _userEntity;
    emit(UserDataSuccess(user));
    return _userEntity;
  }

  void clearUser() {
    _userEntity = null;
    mainAppBloc.setGlobalUserData = _userEntity;
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> getUserDataStatesHandled({String? visitorName}) async {
    if (!Utility.isUserLoggedIn()) {
      _loginAsGuest(visitorName: visitorName);
      return;
    }
    CustomNavigator.context.loaderOverlay.show();
    emit(const UserDataLoading());
    final response = await UserRepo.getUserData();
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(UserDataError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      await SharedHelper.sharedHelper?.saveUser(success);
      setUser(success);
      return emit(UserDataSuccess(success));
    });
  }
}
