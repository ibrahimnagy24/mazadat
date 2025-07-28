import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/services/pagination/pagination_service.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../logic/addresses_cubit.dart';
import 'addresses_mobile_design.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddressesCubit()..addressesStatesHandled(SearchEngine()),
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => const AddressesMobileDesign(),
          landscape: (context) => const AddressesMobileDesign(),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => const AddressesMobileDesign(),
          landscape: (context) => const AddressesMobileDesign(),
        ),
      ),
    );
  }
}
