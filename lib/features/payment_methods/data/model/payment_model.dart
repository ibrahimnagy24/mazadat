class PaymentModel {
  int? id;
  String? name, code, icon;
  String? type;
  PaymentModel({
    this.id,
    this.name,
    this.code,
    this.icon,
    required this.type,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    icon = json['icon'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['icon'] = icon;
    data['type'] = type;
    return data;
  }
}
