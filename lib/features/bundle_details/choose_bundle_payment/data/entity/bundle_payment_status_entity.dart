import 'package:equatable/equatable.dart';

class BundlePaymentStatusEntity extends Equatable {
  final int bundleId;
  final String message;
  final String status;
  final String code;

  const BundlePaymentStatusEntity({
    required this.bundleId,
    required this.message,
    required this.status,
    required this.code,
  });

  @override
  List<Object?> get props => [
        bundleId,
        message,
        status,
        code,
      ];
}
