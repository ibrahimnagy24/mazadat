import 'package:equatable/equatable.dart';

class ChangePhoneNumberRouteParams extends Equatable {
  const ChangePhoneNumberRouteParams({required this.oldPhone});
  final String oldPhone;

  @override
  List<Object?> get props => [oldPhone];
}
