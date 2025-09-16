import '../../../core/shared/entity/error_entity.dart';
import '../data/entities/contact_us_response_entity.dart';
import '../data/entities/message_type_entity.dart';
import '../data/entities/whatsapp_config_entity.dart';

sealed class ContactUsState {
  const ContactUsState();
}

final class ContactUsInitial extends ContactUsState {}

final class ContactUsLoading extends ContactUsState {}

final class ContactUsSuccess extends ContactUsState {
  const ContactUsSuccess(this.success);
  final ContactUsResponseEntity success;
}

final class ContactUsError extends ContactUsState {
  const ContactUsError(this.error);
  final ErrorEntity error;
}

final class MessageTypesLoading extends ContactUsState {}

final class MessageTypesDone extends ContactUsState {
  const MessageTypesDone(this.messageTypes);
  final List<MessageTypeEntity> messageTypes;
}

final class MessageTypesError extends ContactUsState {
  const MessageTypesError(this.error);
  final ErrorEntity error;
}

final class MessageTypesEmpty extends ContactUsState {}

final class RebuildInputs extends ContactUsState {}

final class WhatsappConfigLoading extends ContactUsState {}

final class WhatsappConfigSuccess extends ContactUsState {
  const WhatsappConfigSuccess(this.whatsappConfig);
  final WhatsappConfigEntity whatsappConfig;
}

final class WhatsappConfigError extends ContactUsState {
  const WhatsappConfigError(this.error);
  final ErrorEntity error;
}
