import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/payment_model.dart';
import '../data/repo/check_out_repo.dart';
import 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(const PaymentMethodsInitial());

//----------------------------------REQUEST-----------------------------------//
  Future<void> getPaymentList() async {
    emit(const PaymentMethodsLoading());

    final response = await CheckOutRepo.getPaymentList();
    response.fold((failure) {
      return emit(PaymentMethodsError(failure));
    }, (success) {
      List<PaymentModel> payments = List<PaymentModel>.from(
          success.data.map((e) => PaymentModel.fromJson(e)));
      if (payments.isNotEmpty) {
        return emit(PaymentMethodsSuccess(payments: payments));
      } else {
        return emit(const PaymentMethodsEmpty());
      }
    });
  }
}
