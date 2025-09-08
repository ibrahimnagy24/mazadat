import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
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
