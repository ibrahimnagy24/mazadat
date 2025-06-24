import 'package:equatable/equatable.dart';

import '../../../../../core/utils/utility.dart';

class VerifyCodeModel extends Equatable {
  const VerifyCodeModel({required this.message});
  final String message;

  factory VerifyCodeModel.fromJson(dynamic json) {
    //"success" => that's the response from the server
    return VerifyCodeModel(
      message: checkFromMap(json) ? json['message'] ?? '' : json.toString(),
    );
  }

  @override
  List<Object?> get props => [message];
}
