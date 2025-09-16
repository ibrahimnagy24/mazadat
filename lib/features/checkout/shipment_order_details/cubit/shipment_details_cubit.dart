import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/app_config/app_config.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/shared/entity/error_entity.dart';
import '../../../../core/utils/constant/app_strings.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../data/entity/shipment_details_entity.dart';
import '../data/params/shipment_details_params.dart';
import '../data/params/shipment_details_route_params.dart';
import '../data/repo/shipment_details_repo.dart';
import 'shipment_details_state.dart';
import 'package:url_launcher/url_launcher.dart';

class ShipmentDetailsCubit extends Cubit<ShipmentDetailsState> {
  ShipmentDetailsCubit() : super(ShipmentDetailsInitial());

//---------------------------------VARIABLES----------------------------------//
  ShipmentDetailsEntity? shipmentDetails;
  late ShipmentDetailsRouteParams routeParams;
  late ShipmentDetailsParams params;

//---------------------------------FUNCTIONS----------------------------------//
  void init(ShipmentDetailsRouteParams routeParams) {
    this.routeParams = routeParams;
    params = ShipmentDetailsParams(shipmentId: routeParams.shipmentId);
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> getShipmentDetailsStatesHandled() async {
    CustomNavigator.context.loaderOverlay.show();
    emit(ShipmentDetailsLoading());
    final response = await ShipmentDetailsRepo.getShipmentDetails(params);
    response.fold((failure) {
      CustomNavigator.context.loaderOverlay.hide();
      return emit(ShipmentDetailsError(failure));
    }, (success) async {
      CustomNavigator.context.loaderOverlay.hide();
      shipmentDetails = success;
      return emit(ShipmentDetailsLoaded(success));
    });
  }

  Future<void> downloadInvoiceStatesHandled() async {
    if (shipmentDetails?.data.id == null) {
      emit(
        DownloadInvoiceError(ErrorEntity(
          statusCode: 400,
          message: AppStrings.paymentTransactionIdNotFound.tr,
          errors: const [],
        )),
      );
      return;
    }

    try {
      CustomNavigator.context.loaderOverlay.show();
      emit(DownloadInvoiceLoading());

      final url =
          '${AppConfig.BASE_URL}/reports/generateInvoice?id=${shipmentDetails!.data.id}';
      final launched =
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

      CustomNavigator.context.loaderOverlay.hide();

      if (launched) {
        emit(DownloadInvoiceSuccess(AppStrings.invoiceDownloadStarted.tr));
      } else {
        emit(DownloadInvoiceError(ErrorEntity(
          statusCode: 500,
          message: AppStrings.couldNotLaunchInvoiceUrl.tr,
          errors: const [],
        )));
      }
    } catch (error) {
      CustomNavigator.context.loaderOverlay.hide();
      emit(DownloadInvoiceError(ErrorEntity(
        statusCode: 500,
        message: '${AppStrings.errorLaunchingInvoice.tr}: ${error.toString()}',
        errors: const [],
      )));
    }
  }
}
