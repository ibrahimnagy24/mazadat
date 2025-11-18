import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/checkout_summary_entity.dart';
import '../data/params/checkout_summary_route_params.dart';
import '../data/params/get_checout_summary_params.dart';
import '../data/params/validate_summary_params.dart';
import '../data/repo/checkout_summary_repo.dart';
import 'checkout_summary_state.dart';

class CheckoutSummaryCubit extends Cubit<CheckoutSummaryState> {
  CheckoutSummaryCubit() : super(CheckoutSummaryInitial());
//---------------------------------VARIABLES----------------------------------//
  CheckoutSummaryEntity? checkoutSummary;
  late CheckoutSummaryRouteParams routeParams;
  late GetCheckoutSummaryParams params;
//---------------------------------FUNCTIONS----------------------------------//
  void init(CheckoutSummaryRouteParams routeParams) {
    this.routeParams = routeParams;
    params = GetCheckoutSummaryParams(auctionId: routeParams.auctionId);
  }

  void checkIfCheckoutTimeFinished() {
    emit(AutionCheckoutTimeFinished());
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> getCheckoutSummaryStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(CheckoutSummaryLoading());
    final response = await CheckoutSummaryRepo.getCheckoutSummary(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(CheckoutSummaryError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      checkoutSummary = success;
      return emit(CheckoutSummaryLoaded(success));
    });
  }

  Future<void> validateSummaryStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(ValidateSummaryLoading());
    final response = await CheckoutSummaryRepo.validateSummary(
      ValidateSummaryParams(auctionId: routeParams.auctionId),
    );
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ValidateSummaryError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ValidateSummaryLoaded(success));
    });
  }
}
