import 'package:equatable/equatable.dart';

class SeenNotificationResponseEntity extends Equatable {
  final String message;
  final String status;

  const SeenNotificationResponseEntity({
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [message, status];
}
