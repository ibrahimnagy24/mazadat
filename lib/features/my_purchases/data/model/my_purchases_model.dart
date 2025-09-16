import '../../../../core/services/pagination/pagination_service.dart';
import 'my_purchase_content_model.dart';

class MyPurchasesModel {
  List<MyPurchaseContentModel>? content;
  SearchEngine? pageable;

  MyPurchasesModel({this.content, this.pageable});

  MyPurchasesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <MyPurchaseContentModel>[];
      json['content'].forEach((v) {
        content!.add(MyPurchaseContentModel.fromJson(v));
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
