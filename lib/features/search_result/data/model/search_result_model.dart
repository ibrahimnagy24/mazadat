import '../../../../core/services/pagination/pagination_service.dart';
import '../../../auctions/data/model/auction_model.dart';

class SearchResultModel {
  List<AuctionModel>? content;
  SearchEngine? pageable;

  SearchResultModel({this.content, this.pageable});

  SearchResultModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <AuctionModel>[];
      json['content'].forEach((v) {
        content!.add(AuctionModel.fromJson(v));
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
