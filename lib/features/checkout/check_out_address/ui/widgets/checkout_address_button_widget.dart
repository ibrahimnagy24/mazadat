import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/navigation/routes.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../check_out_summary/data/params/checkout_summary_route_params.dart';
import '../../cubit/checkout_address_cubit.dart';
import '../../cubit/checkout_address_state.dart';

class CheckoutAddressButtonWidget extends StatelessWidget {
  const CheckoutAddressButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutAddressCubit, CheckoutAddressState>(
      listener: (context, state) {
        if (state is SetDefaultAddressError) {
          ToastService.showCustom(
            message: state.error.message,
            context: context,
            toastStatusType: ToastStatusType.error,
            errorEntity: state.error,
          );
        }
        if (state is SetDefaultAddressSuccess) {
          ToastService.showCustom(
            message: state.checkoutModel.message,
            context: context,
            toastStatusType: ToastStatusType.success,
          );
          CustomNavigator.push(
            Routes.CHECKOUT_SUMMARY,
            extra: CheckoutSummaryRouteParams(
              auctionId:
                  context.read<CheckoutAddressCubit>().routeParams.auctionId,
              cubit: context.read<CheckoutAddressCubit>().routeParams.cubit,
            ),
            replace: true,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is SetDefaultAddressLoading ||
          current is SetDefaultAddressSuccess ||
          current is SetDefaultAddressError,
      builder: (context, state) {
        return DefaultButton(
          text: AppStrings.next.tr,
          onPressed: () {
            context.read<CheckoutAddressCubit>().setDefaultAddress();
          },
          isLoading: state is SetDefaultAddressLoading,
        );
      },
    );
  }
}
