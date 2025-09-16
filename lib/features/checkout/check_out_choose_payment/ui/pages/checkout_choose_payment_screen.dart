import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../cubit/checkout_payment_cubit.dart';
import '../../cubit/checkout_payment_state.dart';
import '../../data/params/checkout_choose_payment_route_params.dart';
import '../widgets/checkout_payment_header_widget.dart';
import '../widgets/payment_methods_list_section.dart';
import '../widgets/payment_method_selection_section.dart';

class CheckoutChoosePaymentScreen extends StatelessWidget {
  const CheckoutChoosePaymentScreen({
    super.key,
    required this.params,
  });

  final CheckoutChoosePaymentRouteParams params;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutPaymentCubit()
        ..init(params)
        ..getPaymentMethodsStatesHandled(),
      child: CustomScaffoldWidget(
        child: BlocConsumer<CheckoutPaymentCubit, CheckoutPaymentState>(
          listener: (context, state) {
            if (state is SelectPaymentMethodSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.GREEN,
                ),
              );
              CustomNavigator.pop();
            }
            if (state is SelectPaymentMethodError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.message),
                  backgroundColor: AppColors.RED,
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<CheckoutPaymentCubit>();
            return Column(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        CheckoutPaymentHeaderWidget(),
                        SizedBox(height: 16),
                        Expanded(child: PaymentMethodsListSection()),
                      ],
                    ),
                  ),
                ),
                PaymentMethodSelectionSection(params: params),
              ],
            );
          },
        ),
      ),
    );
  }
}
