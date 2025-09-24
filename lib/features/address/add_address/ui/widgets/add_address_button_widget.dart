import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant/app_strings.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/utils/widgets/buttons/default_button.dart';
import '../../../delete_address/ui/delete_address_button.dart';
import '../../../addresses/data/model/addresses_model.dart';
import '../../logic/add_address_cubit.dart';
import '../../logic/add_address_state.dart';

class AddAddressButtonWidget extends StatelessWidget {
  const AddAddressButtonWidget({super.key, required this.model});

  final AddressModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      builder: (context, state) {
        return SafeArea(
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: DefaultButton(
                  text: AppStrings.saveChanges.tr,
                  isLoading: state is AddAddressLoading,
                  onPressed: () {
                    if (context.read<AddAddressCubit>().isBodyValid()) {
                      context.read<AddAddressCubit>().addAddressStatesHandled();
                    }
                  },
                ),
              ),
              if (model?.id != null)
                Expanded(child: DeleteAddressButton(id: model?.id ?? 0))
            ],
          ),
        );
      },
    );
  }
}
