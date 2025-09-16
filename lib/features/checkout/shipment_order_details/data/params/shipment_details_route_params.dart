class ShipmentDetailsRouteParams {
  final int shipmentId;

  const ShipmentDetailsRouteParams({
    required this.shipmentId,
  });

  factory ShipmentDetailsRouteParams.fromMap(Map<String, dynamic> map) {
    return ShipmentDetailsRouteParams(
      shipmentId: int.tryParse(map['shipmentId'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shipmentId': shipmentId,
    };
  }
}
