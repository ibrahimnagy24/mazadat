import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../core/utils/constant/app_constant.dart';
import '../../../addresses/data/model/addresses_model.dart';
import '../../logic/add_address_cubit.dart';
import 'add_addresses_mobile_design.dart';

class AddAddressesScreen extends StatelessWidget {
  const AddAddressesScreen({super.key, this.model});
  final AddressModel? model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressCubit()..initAddAddress(model),
      child: ScreenTypeLayout.builder(
        breakpoints: AppConstant.breakpoints,
        mobile: (_) => OrientationLayoutBuilder(
          portrait: (context) => AddAddressesMobileDesign(model: model),
          landscape: (context) => AddAddressesMobileDesign(model: model),
        ),
        tablet: (_) => OrientationLayoutBuilder(
          portrait: (context) => AddAddressesMobileDesign(model: model),
          landscape: (context) => AddAddressesMobileDesign(model: model),
        ),
      ),
    );
  }
}
