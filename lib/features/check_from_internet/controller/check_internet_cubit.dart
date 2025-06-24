import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'check_internet_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  final InternetConnectionChecker _internetConnectionChecker =
      InternetConnectionChecker.createInstance();

  InternetConnectionCubit() : super(InternetConnectionInitial()) {
    _internetConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          emit(InternetConnectionConnected());
        case InternetConnectionStatus.disconnected:
          emit(InternetConnectionDisconnected());
        case InternetConnectionStatus.slow:
          emit(InterConnectionSlow());
      }
    });
  }

  Future<void> checkConnection() async {
    final isConnected = await _internetConnectionChecker.hasConnection;
    if (isConnected) {
      emit(InternetConnectionConnected());
    } else {
      emit(InternetConnectionDisconnected());
    }
  }
}
