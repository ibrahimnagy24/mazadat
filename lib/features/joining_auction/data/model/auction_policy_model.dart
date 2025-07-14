class AuctionPolicyModel {
  int? id;
  String? policy;
  String? commissionAmount, insuranceAmount;
  DateTime? lastModified;

  AuctionPolicyModel({
    this.id,
    this.policy,
    this.commissionAmount,
    this.insuranceAmount,
    this.lastModified,
  });

  AuctionPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policy = json['CONTENT'];
    commissionAmount = json['COMMISSION_AMOUNT'];
    insuranceAmount = json['INSURANCE_AMOUNT'];
    lastModified = json['LAST_UPDATE_DATE'] != null
        ? DateTime.tryParse(json['LAST_UPDATE_DATE'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CONTENT'] = policy;
    data['COMMISSION_AMOUNT'] = commissionAmount;
    data['INSURANCE_AMOUNT'] = insuranceAmount;
    data['LAST_UPDATE_DATE'] = lastModified?.toIso8601String();

    return data;
  }
}

class AttachmentModel {
  String? url;
  bool isVideo;
  AttachmentModel({this.url, this.isVideo = false});
}
