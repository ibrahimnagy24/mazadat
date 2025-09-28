import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/shared/models/auction_policy_model.dart';
import '../data/params/check_insurance_payment_params.dart';
import '../data/params/validate_bundle_params.dart';
import '../data/repo/joining_bundle_repo.dart';
import 'validate_joining_bundle_state.dart';

class ValidateJoiningBundleCubit extends Cubit<ValidateJoiningBundleState> {
  ValidateJoiningBundleCubit() : super(ValidateJoiningBundleInitial()) {
    updateCommission(false);
    updateInsurance(false);
  }

//---------------------------------VARIABLES----------------------------------//

  final commission = BehaviorSubject<bool>();
  Function(bool) get updateCommission => commission.sink.add;
  Stream<bool> get commissionStream => commission.stream.asBroadcastStream();

  final insurance = BehaviorSubject<bool>();
  Function(bool) get updateInsurance => insurance.sink.add;
  Stream<bool> get insuranceStream => insurance.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  Future<void> validate(ValidateBundleParams params) async {
    emit(ValidateJoiningBundleLoading());
    try {
      final response = await JoiningBundleRepo.validateJoiningBundle(params);
      response.fold((failure) {
        return emit(ValidateJoiningBundleError(failure));
      }, (success) {
        if (success.statusCode == 200 && success.data != null) {
          return emit(ValidateJoiningBundleSuccess(
              data: AuctionPolicyModel.fromJson(success.data)));
        } else {
          return emit(ValidateJoiningBundleError(ErrorEntity(
              message: success.data['MESSAGE'],
              statusCode: success.statusCode ?? 400,
              errors: const [])));
        }
      });
    } catch (e) {
      return emit(ValidateJoiningBundleError(ErrorEntity(
          message: e.toString(), statusCode: 400, errors: const [])));
    }
  }

  // Future<void> submitJoining({
  //   required int bundleId,
  //   required int paymentTypeId,
  // }) async {
  //   emit(SubmitJoiningBundleLoading());
  //   try {
  //     final response = await JoiningBundleRepo.submitJoining({
  //       'bundleId': bundleId,
  //       'paymentType': paymentTypeId,
  //     });
  //     response.fold((failure) {
  //       return emit(SubmitJoiningBundleError(failure));
  //     }, (success) {
  //       if (success.isSuccess) {
  //         final message = success.message ?? 'تم الانضمام بنجاح';
  //         return emit(SubmitJoiningBundleSuccess(
  //           message,
  //           transactionId: success.transactionId,
  //           formLink: success.formLink,
  //         ));
  //       } else {
  //         return emit(SubmitJoiningBundleError(ErrorEntity(
  //             message: success.message ?? 'حدث خطأ',
  //             statusCode: int.tryParse(success.code ?? '400') ?? 400,
  //             errors: const [])));
  //       }
  //     });
  //   } catch (e) {
  //     return emit(SubmitJoiningBundleError(ErrorEntity(
  //         message: e.toString(), statusCode: 400, errors: const [])));
  //   }
  // }

  Future<void> checkInsurancePayment(int bundleId, int transactionId) async {
    emit(CheckInsurancePaymentLoading());
    try {
      final params = CheckInsurancePaymentParams(
        bundleId: bundleId,
        paymentTransactionId: transactionId,
      );

      final response = await JoiningBundleRepo.checkInsurancePayment(params);
      response.fold((failure) {
        emit(CheckInsurancePaymentError(failure));
      }, (success) {
        if (success.statusCode == 200 && success.data != null) {
          final message =
              success.data['MESSAGE'] ?? 'تم الاشتراك فى المزاد بنجاح';
          emit(CheckInsurancePaymentSuccess(message));
        } else {
          emit(CheckInsurancePaymentError(ErrorEntity(
              message: success.data['MESSAGE'] ?? 'حدث خطأ',
              statusCode: success.statusCode ?? 400,
              errors: const [])));
        }
      });
    } catch (e) {
      emit(CheckInsurancePaymentError(ErrorEntity(
          message: e.toString(), statusCode: 400, errors: const [])));
    }
  }
}
