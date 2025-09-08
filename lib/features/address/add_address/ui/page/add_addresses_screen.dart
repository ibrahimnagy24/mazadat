import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../address_types/logic/address_types_cubit.dart';
import '../../../addresses/data/model/addresses_model.dart';
import '../../logic/add_address_cubit.dart';
import 'add_addresses_mobile_design.dart';

class AddAddressesScreen extends StatelessWidget {
  const AddAddressesScreen({super.key, this.model});
  final AddressModel? model;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddAddressCubit()..initAddAddress(model),
        ),
        BlocProvider(
          create: (context) =>
              AddressTypesCubit()..addressTypesStatesHandled(SearchEngine()),
        ),
      ],
      child: AddAddressesMobileDesign(model: model),
    );
  }
}
