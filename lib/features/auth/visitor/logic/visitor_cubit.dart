import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/device_info/device_info_service.dart';
import '../../../../core/shared/blocs/main_app_bloc.dart';
import '../data/params/visitor_login_params.dart';
import '../data/repo/visitor_repo.dart';
import 'visitor_state.dart';

class VisitorCubit extends Cubit<VisitorState> {
  VisitorCubit() : super(const VisitorInitial());
//---------------------------------VARIABLES----------------------------------//

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST-----------------------------------//
  Future<void> visitorLoginStatesHandled({
    List<Map<String, dynamic>>? categories,
  }) async {
    emit(const VisitorLoginLoading());
    log('xx $categories');

    final deviceInfo = await DeviceInfoService.getDeviceInfo();
    final VisitorLoginParams params = VisitorLoginParams(
      deviceName: deviceInfo.deviceName,
      deviceType: deviceInfo.platform,
      lang: mainAppBloc.globalLang,
      categories: categories ?? [],
    );
    final response = await VisitorRepo.login(params);
    response.fold((failure) {
      return emit(VisitorLoginError(failure));
    }, (success) async {
      return emit(VisitorLoginSuccess(success));
    });
  }
}
