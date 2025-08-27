class AuctionPolicyModel {
  int? id;
  String? policy;
  DateTime? lastModified;

  AuctionPolicyModel({
    this.id,
    this.policy,
    this.lastModified,
  });

  AuctionPolicyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policy = json['policy'];
    lastModified = json['lastModified'] != null
        ? DateTime.tryParse(json['lastModified'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['policy'] = policy;
    data['lastModified'] = lastModified?.toIso8601String();

    return data;
  }
}

class AttachmentModel {
  String? url;
  bool isVideo;
  AttachmentModel({this.url, this.isVideo = false});
}
