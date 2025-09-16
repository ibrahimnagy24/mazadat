import 'package:equatable/equatable.dart';

import '../../../../../core/shared/entity/error_entity.dart';
import '../data/entity/shipment_details_entity.dart';

abstract class ShipmentDetailsState extends Equatable {
  const ShipmentDetailsState();

  @override
  List<Object?> get props => [];
}

class ShipmentDetailsInitial extends ShipmentDetailsState {}

class ShipmentDetailsLoading extends ShipmentDetailsState {}

class ShipmentDetailsLoaded extends ShipmentDetailsState {
  final ShipmentDetailsEntity shipmentDetails;

  const ShipmentDetailsLoaded(this.shipmentDetails);

  @override
  List<Object?> get props => [shipmentDetails];
}

class ShipmentDetailsError extends ShipmentDetailsState {
  final ErrorEntity error;

  const ShipmentDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}

class DownloadInvoiceLoading extends ShipmentDetailsState {}

class DownloadInvoiceSuccess extends ShipmentDetailsState {
  final String invoiceData;

  const DownloadInvoiceSuccess(this.invoiceData);

  @override
  List<Object?> get props => [invoiceData];
}

class DownloadInvoiceError extends ShipmentDetailsState {
  final ErrorEntity error;

  const DownloadInvoiceError(this.error);

  @override
  List<Object?> get props => [error];
}
