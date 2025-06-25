import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../shared/login_as_visitor_text_widget.dart';
import '../../logic/register_cubit.dart';
import 'create_account_button_widget.dart';
import 'privacy_and_conditions_widget.dart';

class RegisterActions extends StatelessWidget {
  const RegisterActions({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: context.read<RegisterCubit>().stepStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              if (snapshot.data == 1) ...[
                const PrivacyAndConditionsWidget(),
                const CreateAccountButtonWidget()
              ] else ...[
                DefaultButton(
                  text: AppStrings.next.tr,
                  onPressed: () {
                    if (context
                        .read<RegisterCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<RegisterCubit>().updateStep(1);
                    }
                  },
                ),
                const LoginAsVisitorTextWidget()
              ]
            ],
          );
        });
  }
}
