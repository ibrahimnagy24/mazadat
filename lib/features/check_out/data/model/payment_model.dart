class PaymentModel {
  int? id;
  String? name, code;

  PaymentModel({
    this.id,
    this.name,
    this.code,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class AttachmentModel {
  String? url;
  bool isVideo;
  AttachmentModel({this.url, this.isVideo = false});
}
