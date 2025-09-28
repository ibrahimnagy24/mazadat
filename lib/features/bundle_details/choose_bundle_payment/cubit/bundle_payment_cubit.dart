import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/bundle_payment_entity.dart';
import '../data/params/bundle_choose_payment_route_params.dart';
import '../data/params/bundle_payment_params.dart';
import '../data/params/bundle_payment_status_params.dart';
import '../data/params/submit_joining_payment_params.dart';
import '../data/repo/bundle_payment_repo.dart';
import 'bundle_payment_state.dart';

class BundlePaymentCubit extends Cubit<BundlePaymentState> {
  BundlePaymentCubit() : super(const BundlePaymentInitial());

  //---------------------------------VARIABLES----------------------------------//
  BundlePaymentEntity? paymentMethods;
  BundlePaymentMethodEntity? selectedPaymentMethod;
  int? selectedPaymentMethodId;
  late BundleChoosePaymentRouteParams routeParams;
  //---------------------------------FUNCTIONS----------------------------------//
  void init(BundleChoosePaymentRouteParams routeParams) {
    this.routeParams = routeParams;
  }

  void selectPaymentMethod(BundlePaymentMethodEntity paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    selectedPaymentMethodId = paymentMethod.id;
    emit(BundlePaymentLoaded(paymentMethods!));
  }

  void clearSelection() {
    selectedPaymentMethod = null;
    selectedPaymentMethodId = null;
    emit(BundlePaymentLoaded(paymentMethods!));
  }

  //----------------------------------REQUESTS----------------------------------//
  Future<void> getPaymentMethodsStatesHandled() async {
    emit(const BundlePaymentLoading());

    final response = await BundlePaymentRepo.getPaymentMethods(
      GetBundlePaymentMethodsParams(
        bundleId: routeParams.bundleId,
        checkoutId: null,
      ),
    );

    response.fold(
      (failure) {
        return emit(BundlePaymentError(failure));
      },
      (success) {
        paymentMethods = success;
        return emit(BundlePaymentLoaded(success));
      },
    );
  }

  Future<void> selectPaymentMethodStatesHandled({
    required int paymentMethodId,
    required int bundleId,
    String? checkoutId,
  }) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const SubmitJoiningLoading());

    final params = SubmitJoiningPaymentParams(
      bundleId: bundleId,
      paymentType: paymentMethodId,
    );

    final response = await BundlePaymentRepo.submitJoining(params);

    response.fold(
      (failure) {
        CustomNavigator.context.loaderOverlay.hide();
        return emit(SubmitJoiningError(failure));
      },
      (success) {
        CustomNavigator.context.loaderOverlay.hide();
        return emit(SubmitJoiningSuccess(success));
      },
    );
  }

  Future<void> getBundlePaymentStatusStatesHandled(
      {required int paymentTransactionId}) async {
    emit(const BundlePaymentStatusLoading());

    final response = await BundlePaymentRepo.getBundlePaymentStatus(
      BundlePaymentStatusParams(
        bundleId: routeParams.bundleId,
        paymentTransactionId: paymentTransactionId,
      ),
    );

    response.fold(
      (failure) {
        return emit(BundlePaymentStatusError(failure));
      },
      (success) {
        return emit(BundlePaymentStatusSuccess(success));
      },
    );
  }
}
