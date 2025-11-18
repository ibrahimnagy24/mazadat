import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/errors/error_message_widget.dart';
import '../../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../cubit/shipment_details_cubit.dart';
import '../../cubit/shipment_details_state.dart';
import '../../data/params/shipment_details_route_params.dart';
import '../widgets/shipment_details_header_widget.dart';
import '../widgets/shipment_order_details_widget.dart';
import '../widgets/shipment_delivery_address_widget.dart';
import '../widgets/shipment_purchase_details_widget.dart';
import '../widgets/shipment_status_widget.dart';

class ShipmentOrderDetailsScreen extends StatelessWidget {
  const ShipmentOrderDetailsScreen({
    super.key,
    required this.params,
  });

  final ShipmentDetailsRouteParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShipmentDetailsCubit()
        ..init(params)
        ..getShipmentDetailsStatesHandled(),
      child: CustomScaffoldWidget(
        child: BlocBuilder<ShipmentDetailsCubit, ShipmentDetailsState>(
          builder: (context, state) {
            final cubit = context.read<ShipmentDetailsCubit>();
            if (state is ShipmentDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ShipmentDetailsError) {
              return ErrorMessageWidget(
                error: state.error,
                message: state.error.message,
                onTap: () {
                  context
                      .read<ShipmentDetailsCubit>()
                      .getShipmentDetailsStatesHandled();
                },
              );
            }

            if (state is ShipmentDetailsLoaded ||
                cubit.shipmentDetails != null) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const ShipmentDetailsHeaderWidget(),
                            const SizedBox(height: 16),
                            const ShipmentOrderDetailsWidget(),
                            const SizedBox(height: 16),
                            ShipmentStatusWidget(
                              status: cubit.shipmentDetails!.data.status,
                            ),
                            const SizedBox(height: 16),
                            const ShipmentDeliveryAddressWidget(),
                            const SizedBox(height: 17),
                            const ShipmentPurchaseDetailsWidget(),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
