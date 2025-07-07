import 'package:flutter/material.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';

class LoginRememberMeWidget extends StatelessWidget {
  const LoginRememberMeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        CustomNavigator.push(Routes.FORGET_PASSWORD_SCREEN);
      },
      child: Text(
        AppStrings.forgotYourPassword.tr,
        style: AppTextStyles.textSmSemibold,
        textAlign: TextAlign.start,
      ),
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     // Expanded(
    //     //   flex: 2,
    //     //   child: Row(
    //     //     mainAxisAlignment: MainAxisAlignment.start,
    //     //     children: [
    //     //       BlocBuilder<LoginCubit, LoginState>(
    //     //         buildWhen: (previous, current) => current is RememberMeStates,
    //     //         builder: (context, state) {
    //     //           return Checkbox.adaptive(
    //     //             value: cubit.rememberMe,
    //     //             activeColor: AppColors.kPrimary,
    //     //             checkColor: AppColors.kGeryText3,
    //     //             fillColor: WidgetStateProperty.resolveWith<Color>(
    //     //                 (Set<WidgetState> states) {
    //     //               if (states.contains(WidgetState.selected)) {
    //     //                 return AppColors.kPrimary;
    //     //               }
    //     //               return Colors.white;
    //     //             }),
    //     //             onChanged: (value) {
    //     //               cubit.toggleRememberMeFunction();
    //     //             },
    //     //             shape: RoundedRectangleBorder(
    //     //               borderRadius: BorderRadius.circular(4),
    //     //               side: const BorderSide(color: AppColors.kGeryText3),
    //     //             ),
    //     //             side: const BorderSide(
    //     //               color: AppColors.kGeryText3,
    //     //               width: 1,
    //     //             ),
    //     //           );
    //     //         },
    //     //       ),
    //     //       Expanded(
    //     //         child: Padding(
    //     //           padding: const EdgeInsetsDirectional.only(bottom: 4),
    //     //           child: Text(
    //     //             AppStrings.rememberMe.tr,
    //     //             style: AppTextStyles.bodyXXsReq
    //     //                 .copyWith(color: AppColors.kGeryText3),
    //     //             textAlign: TextAlign.start,
    //     //           ),
    //     //         ),
    //     //       ),
    //     //     ],
    //     //   ),
    //     // ),
    //     Expanded(
    //       child: ,
    //     )
    //   ],
    // );
  }
}
