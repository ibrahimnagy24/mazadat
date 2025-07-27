import '../../../../core/services/pagination/pagination_service.dart';
import '../../../auctions/data/model/auction_model.dart';

class MyPurchasesModel {
  List<AuctionModel>? content;
  SearchEngine? pageable;

  MyPurchasesModel({this.content, this.pageable});

  MyPurchasesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <AuctionModel>[];
      json['content'].forEach((v) {
        content!.add(AuctionModel.fromJsonMyPurchases(v['auction'],
            orderNumber: v['orderNumber']));
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
