import 'package:equatable/equatable.dart';

class ResetPasswordRouteParams extends Equatable {
  const ResetPasswordRouteParams({required this.phone,required this.otp});
  final String phone;
  final String otp;

  @override
  List<Object?> get props => [phone,otp];
}
