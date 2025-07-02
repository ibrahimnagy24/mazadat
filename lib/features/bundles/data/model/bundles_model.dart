import '../../../../core/services/pagination/pagination_service.dart';
import 'bundle_model.dart';

class BundlesModel {
  List<BundleModel>? content;
  SearchEngine? pageable;

  BundlesModel({this.content, this.pageable});

  BundlesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <BundleModel>[];
      json['content'].forEach((v) {
        content!.add(BundleModel.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? SearchEngine.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }
}
