class AuctionPolicyModel {
  int? id;
  String? policy;
  String? commissionAmount, insuranceAmount;
  DateTime? lastModified;
  String? message;
  String? status;
  String? code;
  List<dynamic>? notAllowed;

  AuctionPolicyModel({
    this.id,
    this.policy,
    this.commissionAmount,
    this.insuranceAmount,
    this.lastModified,
    this.message,
    this.status,
    this.code,
    this.notAllowed,
  });

  AuctionPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policy = json['CONTENT'];
    commissionAmount = json['COMMISSION_AMOUNT']?.toString();
    insuranceAmount = json['INSURANCE_AMOUNT']?.toString();
    message = json['MESSAGE'];
    status = json['STATUS'];
    code = json['CODE'];
    notAllowed = json['NOT_ALLOWED'];
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
    data['MESSAGE'] = message;
    data['STATUS'] = status;
    data['CODE'] = code;
    data['NOT_ALLOWED'] = notAllowed;
    data['LAST_UPDATE_DATE'] = lastModified?.toIso8601String();

    return data;
  }

  // Helper getters for easier access
  bool get isSuccess => status == 'SUCCESS';
  bool get isAllowed => notAllowed?.isEmpty ?? true;
  double get commissionAmountDouble => double.tryParse(commissionAmount ?? '0') ?? 0.0;
  double get insuranceAmountDouble => double.tryParse(insuranceAmount ?? '0') ?? 0.0;
}

