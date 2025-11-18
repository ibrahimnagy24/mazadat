import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/navigation/custom_navigation.dart';
import '../data/entity/checkout_payment_entity.dart';
import '../data/params/checkout_choose_payment_route_params.dart';
import '../data/params/checkout_payment_params.dart';
import '../data/params/confirm_checkout_params.dart';
import '../data/params/payment_status_params.dart';
import '../data/repo/checkout_payment_repo.dart';
import 'checkout_payment_state.dart';

class CheckoutPaymentCubit extends Cubit<CheckoutPaymentState> {
  CheckoutPaymentCubit() : super(const CheckoutPaymentInitial());

  //---------------------------------VARIABLES----------------------------------//
  CheckoutPaymentEntity? paymentMethods;
  CheckoutPaymentMethodEntity? selectedPaymentMethod;
  int? selectedPaymentMethodId;
  late CheckoutChoosePaymentRouteParams routeParams;
  //---------------------------------FUNCTIONS----------------------------------//
  void init(CheckoutChoosePaymentRouteParams routeParams) {
    this.routeParams = routeParams;
  }

  void selectPaymentMethod(CheckoutPaymentMethodEntity paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    selectedPaymentMethodId = paymentMethod.id;
    emit(CheckoutPaymentLoaded(paymentMethods!));
  }

  void clearSelection() {
    selectedPaymentMethod = null;
    selectedPaymentMethodId = null;
    emit(CheckoutPaymentLoaded(paymentMethods!));
  }

  //----------------------------------REQUESTS----------------------------------//
  Future<void> getPaymentMethodsStatesHandled() async {
    emit(const CheckoutPaymentLoading());

    final response = await CheckoutPaymentRepo.getPaymentMethods(
      GetCheckoutPaymentMethodsParams(
        auctionId: routeParams.auctionId,
        checkoutId: null,
      ),
    );

    response.fold(
      (failure) {
        return emit(CheckoutPaymentError(failure));
      },
      (success) {
        paymentMethods = success;
        return emit(CheckoutPaymentLoaded(success));
      },
    );
  }

  Future<void> selectPaymentMethodStatesHandled({
    required int paymentMethodId,
    required int auctionId,
    String? checkoutId,
  }) async {
    CustomNavigator.context.loaderOverlay.show();
    emit(const SelectPaymentMethodLoading());

    final params = SelectPaymentMethodParams(
      paymentMethodId: paymentMethodId,
      auctionId: auctionId,
      checkoutId: checkoutId,
    );

    final response = await CheckoutPaymentRepo.selectPaymentMethod(params);

    response.fold(
      (failure) {
        CustomNavigator.context.loaderOverlay.hide();
        return emit(SelectPaymentMethodError(failure));
      },
      (success) {
        CustomNavigator.context.loaderOverlay.hide();
        final message =
            success.data['MESSAGE'] ?? 'Payment method selected successfully';
        return emit(SelectPaymentMethodSuccess(message));
      },
    );
  }

  Future<void> confirmCheckoutStatesHandled({required int paymentType}) async {
    emit(const ConfirmCheckoutLoading());

    final response = await CheckoutPaymentRepo.confirmCheckout(
      ConfirmCheckoutParams(
        auctionId: routeParams.auctionId,
        paymentType: paymentType,
      ),
    );

    response.fold(
      (failure) {
        return emit(ConfirmCheckoutError(failure));
      },
      (success) {
        return emit(ConfirmCheckoutSuccess(success));
      },
    );
  }

  Future<void> getPaymentStatusStatesHandled({
    required int paymentTransactionId,
  }) async {
    emit(const PaymentStatusLoading());

    final response = await CheckoutPaymentRepo.getPaymentStatus(
      PaymentStatusParams(
        auctionId: routeParams.auctionId,
        paymentTransactionId: paymentTransactionId,
      ),
    );

    response.fold(
      (failure) {
        return emit(PaymentStatusError(failure));
      },
      (success) {
        return emit(PaymentStatusSuccess(success));
      },
    );
  }
}
