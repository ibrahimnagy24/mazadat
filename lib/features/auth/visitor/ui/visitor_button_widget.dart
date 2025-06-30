import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_core.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../../../core/utils/widgets/buttons/default_button.dart';
import '../logic/visitor_cubit.dart';
import '../logic/visitor_state.dart';

class VisitorButtonWidget extends StatelessWidget {
  const VisitorButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiusValue,
    this.fontSize,
    this.buttonText,
    this.categories,
  });
  final double? height;
  final double? width;
  final double? borderRadiusValue;
  final double? fontSize;
  final String? buttonText;

  final List<Map<String, dynamic>>? categories;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitorCubit(),
      child: BlocConsumer<VisitorCubit, VisitorState>(
        listener: (context, state) {
          final cubit = context.read<VisitorCubit>();
          if (state is VisitorLoginError) {
            showErrorSnackBar(state.error.message, error: state.error);
          }
          if (state is VisitorLoginSuccess) {
            showSuccessToast(state.visitor.message);
            CustomNavigator.push(Routes.NAV_BAR_LAYOUT, clean: true);
          }
        },
        buildWhen: (previous, current) =>
            current is VisitorLoginLoading ||
            current is VisitorLoginSuccess ||
            current is VisitorLoginError,
        builder: (context, state) {
          final cubit = context.read<VisitorCubit>();
          return DefaultButton(
            isLoading: state is VisitorLoginLoading,
            text: buttonText ?? AppStrings.loginAsAVisitor.tr,
            onPressed: () async {
              await context
                  .read<VisitorCubit>()
                  .visitorLoginStatesHandled(categories: categories);
            },
            height: height,
            width: width,
            borderRadiusValue: borderRadiusValue,
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}
