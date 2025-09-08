import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/entities/static_page_entity.dart';
import '../data/params/static_page_params.dart';
import '../data/repository/static_page_repo.dart';
import 'static_page_state.dart';

class StaticPageCubit extends Cubit<StaticPageState> {
  StaticPageCubit() : super(const StaticPageInitial());
//---------------------------------VARIABLES----------------------------------//
  StaticPageEntity? staticPageEntity;

//---------------------------------FUNCTIONS----------------------------------//

//----------------------------------REQUEST-----------------------------------//
  Future<void> getStaticPage(StaticPageParams params) async {
    emit(GetStaticPageLoading());
    if (staticPageEntity != null) {
      staticPageEntity = null;
    }
    final response = await StaticPageRepo.staticPage(params);
    response.fold((failure) {
      return emit(GetStaticPageError(failure));
    }, (success) async {
      staticPageEntity = success;
      return emit(GetStaticPageSuccess(success));
    });
  }
}
