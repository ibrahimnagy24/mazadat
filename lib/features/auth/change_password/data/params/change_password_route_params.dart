import 'package:equatable/equatable.dart';

class ChangePasswordRouteParams extends Equatable {
  const ChangePasswordRouteParams({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}
