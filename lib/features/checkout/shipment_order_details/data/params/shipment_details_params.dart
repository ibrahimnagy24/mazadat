class ShipmentDetailsParams {
  final int shipmentId;

  const ShipmentDetailsParams({
    required this.shipmentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'shipmentId': shipmentId,
    };
  }
}
