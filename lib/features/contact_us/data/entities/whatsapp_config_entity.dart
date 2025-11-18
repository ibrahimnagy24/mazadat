import 'package:equatable/equatable.dart';

class WhatsappConfigEntity extends Equatable {
  const WhatsappConfigEntity({
    required this.whatsappNumber,
  });

  final String whatsappNumber;

  @override
  List<Object?> get props => [whatsappNumber];
}
