import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_core.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/widgets/buttons/custom_gradient_button_widget.dart';
import '../logic/visitor_cubit.dart';
import '../logic/visitor_state.dart';

class VisitorButtonWidget extends StatelessWidget {
  const VisitorButtonWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadiousValue,
    this.fontSize,
  });
  final double? height;
  final double? width;
  final double? borderRadiousValue;
  final double? fontSize;

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
          return CustomGradientButtonWidget(
            isLoading: state is VisitorLoginLoading,
            text: 'AppStrings.loginAsAGuest.tr',
            onPressed: () async {
              await context.read<VisitorCubit>().visitorLoginStatesHandled();
            },
            height: height,
            width: width,
            borderRadiousValue: borderRadiousValue,
            fontSize: fontSize,
          );
        },
      ),
    );
  }
}
