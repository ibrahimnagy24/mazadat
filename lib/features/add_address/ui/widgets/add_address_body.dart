import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/animated/animated_widget.dart';
import '../../logic/add_address_cubit.dart';

class AddAddressBody extends StatelessWidget {
  const AddAddressBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: context.read<AddAddressCubit>().formKey,
        child: StreamBuilder(
      ),
    );
  }
}
