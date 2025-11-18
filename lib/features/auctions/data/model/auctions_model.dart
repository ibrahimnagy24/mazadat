// import '../../../../core/services/pagination/pagination_service.dart';
// import 'auction_model.dart';

// class AuctionsModel {
//   List<AuctionModel>? content;
//   SearchEngine? pageable;

//   AuctionsModel({this.content, this.pageable});

//   AuctionsModel.fromJson(Map<String, dynamic> json) {
//     if (json['content'] != null) {
//       content = <AuctionModel>[];
//       json['content'].forEach((v) {
//         content!.add(AuctionModel.fromJson(v));
//       });
//     }
//     pageable = json['pageable'] != null ? SearchEngine.fromJson(json) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (content != null) {
//       data['content'] = content!.map((v) => v.toJson()).toList();
//     }
//     if (pageable != null) {
//       data['pageable'] = pageable!.toJson();
//     }
//     return data;
//   }
// }
