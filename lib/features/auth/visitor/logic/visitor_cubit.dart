import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/visitor_repo.dart';
import 'visitor_state.dart';

class VisitorCubit extends Cubit<VisitorState> {
  VisitorCubit() : super(const VisitorInitial());
//---------------------------------VARIABLES----------------------------------//

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST-----------------------------------//
  Future<void> visitorLoginStatesHandled() async {
    emit(const VisitorLoginLoading());
    final response = await VisitorRepo.login();
    response.fold((failure) {
      return emit(VisitorLoginError(failure));
    }, (success) async {
      // await SharedHelper.sharedHelper?.cacheLoginData(success);
      return emit(VisitorLoginSuccess(success));
    });
  }
}
