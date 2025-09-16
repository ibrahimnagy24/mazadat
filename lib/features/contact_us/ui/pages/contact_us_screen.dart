import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/assets/app_svg.dart';
import '../../../../core/shared/widgets/custom_back_icon.dart';
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/theme/text_styles/text_styles.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/validations/validator.dart';
import '../../../../core/utils/widgets/form_fields/default_email_form_field.dart';
import '../../../../core/utils/widgets/form_fields/default_form_field.dart';
import '../../../../core/utils/widgets/form_fields/default_phone_form_field.dart';
import '../../../../core/utils/widgets/form_fields/default_username_form_field.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../data/params/contact_us_route_params.dart';
import '../../logic/contact_us_cubit.dart';
import '../../logic/contact_us_state.dart';
import '../widgets/contact_us_message_button_widget.dart';
import '../widgets/message_type_input.dart';
import '../widgets/whatsapp_contact_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({
    super.key,
    required this.params,
  });
  final ContactUsRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit()
        ..getMessageTypesStatesHandled()
        ..getWhatsappConfigurationStatesHandled(),
      child: BlocBuilder<ContactUsCubit, ContactUsState>(
        builder: (context, state) {
          final cubit = context.read<ContactUsCubit>();
          final isLoading = state is ContactUsLoading;

          return CustomScaffoldWidget(
            appbarTitle: Text(AppStrings.contactUs.tr),
            needAppbar: true,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              child: BlocBuilder<ContactUsCubit, ContactUsState>(
                buildWhen: (previous, current) => current is RebuildInputs,
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: cubit.formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  const CustomBackIcon(),
                                  const SizedBox(height: 17),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: AppStrings.contactUs.tr,
                                            style: AppTextStyles.textMdBold
                                                .copyWith(
                                              fontSize: 24,
                                              color: const Color.fromRGBO(
                                                  34, 39, 21, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        AppSvg.logo,
                                        height: 56,
                                        width: 78,
                                        color:
                                            const Color.fromRGBO(81, 94, 50, 1),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  DefaultUsernameFormField(
                                    controller: cubit.nameController,
                                    readonly: isLoading,
                                    titleText: AppStrings.fullName.tr,
                                    hintText: AppStrings.enterNameHere.tr,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  DefaultPhoneFormField(
                                    controller: cubit.phoneController,
                                    readOnly: isLoading,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  DefaultEmailFormField(
                                    controller: cubit.emailController,
                                    readOnly: isLoading,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  MessageTypeInput(
                                    initialValue: cubit.messageTypeController,
                                    onSelect: (selected) {
                                      cubit.messageTypeController = selected;
                                      cubit.rebuildInputs();
                                    },
                                    validator: (value) {
                                      if (cubit.messageTypeController == null) {
                                        return AppStrings
                                            .pleaseSelectMessageType.tr;
                                      }
                                      return null;
                                    },
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  DefaultFormField(
                                    controller: cubit.messageController,
                                    titleText: AppStrings.messageType.tr,
                                    hintText: AppStrings.selectMessageType.tr,
                                    maxLines: 5,
                                    readOnly: isLoading,
                                    validator: (value) =>
                                        DefaultValidator.defaultValidator(
                                            value),
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                  const SizedBox(height: 24),
                                  if (cubit.whatsappConfigEntity != null)
                                    WhatsappContactWidget(
                                      whatsappNumber: cubit
                                          .whatsappConfigEntity!.whatsappNumber,
                                    ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const ContactUsMessageButtonWidget(),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
