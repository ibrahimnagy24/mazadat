import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../data/entities/faq_entity.dart';
import '../data/repository/faq_repo.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitial());

//---------------------------------VARIABLES----------------------------------//
  List<FaqEntity>? _faqsEntity;
  String? _lastUpdateDate;

//---------------------------------FUNCTIONS----------------------------------//
  List<FaqEntity>? get faqsEntity => _faqsEntity;
  String? get lastUpdateDate => _lastUpdateDate;

//---------------------------------REQUESTS----------------------------------//
  Future<void> getFaqsStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(FaqLoading());
    final response = await FaqRepo.getFaqs();
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(FaqError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      _faqsEntity = success['faqs'] as List<FaqEntity>?;
      _lastUpdateDate = success['lastUpdateDate'] as String?;
      if (_faqsEntity != null && _faqsEntity!.isNotEmpty) {
        return emit(FaqSuccess(_faqsEntity!));
      }
      return emit(FaqEmpty());
    });
  }
}
