import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/utils/constant/app_constant.dart';
import '../data/entities/message_type_entity.dart';
import '../data/entities/whatsapp_config_entity.dart';
import '../data/params/contact_us_request_params.dart';
import '../data/repository/contact_us_repo.dart';
import 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

//---------------------------------VARIABLES----------------------------------//
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  MessageTypeEntity? messageTypeController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<MessageTypeEntity>? _messageTypesEntity;
  WhatsappConfigEntity? _whatsappConfigEntity;

//---------------------------------FUNCTIONS----------------------------------//
  List<MessageTypeEntity>? get messageTypesEntity => _messageTypesEntity;
  WhatsappConfigEntity? get whatsappConfigEntity => _whatsappConfigEntity;

  void rebuildInputs() {
    emit(RebuildInputs());
  }

  bool isFormValid() {
    if (formKey.currentState!.validate() &&
        messageTypeController != null &&
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        messageController.text.trim().isNotEmpty) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    messageController.dispose();
    return super.close();
  }

//---------------------------------REQUESTS----------------------------------//
  Future<void> getMessageTypesStatesHandled() async {
    emit(MessageTypesLoading());
    final response = await ContactUsRepo.getMessageTypes();
    response.fold((failure) {
      return emit(MessageTypesError(failure));
    }, (success) async {
      _messageTypesEntity = success;
      if (_messageTypesEntity != null && _messageTypesEntity!.isNotEmpty) {
        return emit(MessageTypesDone(success));
      }
      return emit(MessageTypesEmpty());
    });
  }

  Future<void> submitContactUsForm() async {
    if (!isFormValid()) {
      return;
    }
    CustomNavigator.context.loaderOverlay.show();
    emit(ContactUsLoading());
    final response =
        await ContactUsRepo.submitContactRequest(ContactUsRequestParams(
      name: nameController.text.trim(),
      phone: AppConstant.countryCode + phoneController.text.trim(),
      email: emailController.text.trim(),
      message: messageController.text.trim(),
      type: messageTypeController!.id,
    ));
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ContactUsError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ContactUsSuccess(success));
    });
  }

  Future<void> getWhatsappConfigurationStatesHandled() async {
    emit(WhatsappConfigLoading());
    final response = await ContactUsRepo.getWhatsappConfiguration();
    response.fold((failure) {
      return emit(WhatsappConfigError(failure));
    }, (success) async {
      _whatsappConfigEntity = success;
      return emit(WhatsappConfigSuccess(success));
    });
  }
}
