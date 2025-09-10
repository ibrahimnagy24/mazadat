import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors/styles.dart';
import '../../../../../core/theme/text_styles/text_styles.dart';
import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/extensions/media_query_helper.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../../../core/utils/widgets/custom_app_bar.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../cubit/checkout_address_cubit.dart';
import '../../data/params/checkout_address_route_params.dart';
import '../widgets/add_checkout_address_button_widget.dart';
import '../widgets/checkout_address_button_widget.dart';
import '../widgets/checkout_address_header_widget.dart';
import '../widgets/checkout_address_list.dart';

class CheckoutAddressScreen extends StatelessWidget {
  const CheckoutAddressScreen({super.key, required this.params});
  final CheckoutAddressRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutAddressCubit()
        ..init(params)
        ..fetchAddresses(),
      child: const CustomScaffoldWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    CheckoutAddressHeaderWidget(),
                    SizedBox(height: 16),
                    Flexible(
                        child: SingleChildScrollView(
                            child: CheckoutAddressList())),
                    SizedBox(height: 24),
                    AddCheckoutAddressButtonWidget(),
                  ],
                ),
              ),
              SafeArea(child: CheckoutAddressButtonWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
