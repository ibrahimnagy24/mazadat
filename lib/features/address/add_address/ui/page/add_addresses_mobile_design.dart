import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/assets/app_svg.dart';
import '../../../../../core/navigation/custom_navigation.dart';
import '../../../../../core/services/toast_service.dart';
import '../../../../../core/shared/blocs/main_app_bloc.dart';
import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/app_font_size_styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../../core/utils/widgets/text/main_text.dart';
import '../../../addresses/data/model/addresses_model.dart';
import '../../../delete_address/ui/delete_address_button.dart';
import '../../logic/add_address_cubit.dart';
import '../../logic/add_address_state.dart';
import '../widgets/add_address_body.dart';
import '../widgets/add_address_button_widget.dart';
import '../widgets/add_addresses_header_widget.dart';

class AddAddressesMobileDesign extends StatelessWidget {
  const AddAddressesMobileDesign({super.key, this.model});
  final AddressModel? model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: true,
      child: BlocConsumer<AddAddressCubit, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            model?.onSuccess?.call();
            CustomNavigator.pop();
          }
          if (state is AddAddressError) {
            ToastService.showCustom(
              message: state.error.message,
              context: context,
              toastStatusType: ToastStatusType.error,
              errorEntity: state.error,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                AddAddressesHeaderWidget(model: model),
                const SizedBox(height: 26),
                const AddAddressBody(),
                const SizedBox(height: 16),
                AddAddressButtonWidget(model: model),
              ],
            ),
          );
        },
      ),
    );
  }
}
