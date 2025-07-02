import 'package:equatable/equatable.dart';

class ResetPasswordModel extends Equatable {
  const ResetPasswordModel({required this.message});
  final String message;

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      message: json['message'] ?? ' AppStrings.thePasswordHasBeenChanged.tr',
    );
  }

  @override
  List<Object?> get props => [message];
}
