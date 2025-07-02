import 'package:equatable/equatable.dart';

class ChangePasswordModel extends Equatable {
  const ChangePasswordModel({required this.message});
  final String message;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      message: json['message'] ?? ' AppStrings.thePasswordHasBeenChanged.tr',
    );
  }

  @override
  List<Object?> get props => [message];
}
