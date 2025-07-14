class PaymentModel {
  int? id;
  String? name, code, icon;

  PaymentModel({
    this.id,
    this.name,
    this.code,
    this.icon,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['icon'] = icon;
    return data;
  }
}
