import 'package:flutter/material.dart';

import '../../../../category/data/entity/category_entity.dart';
import '../../../../selectors/auction_statuses/data/entity/auction_status_entity.dart';
import '../enum/search_enums.dart';

class FilterParams {
  List<CategoryEntity>? categories;
  AuctionStatusEntity? auctionStatus;
  SearchOrder? order;
  TextEditingController? keywordTEC;
  String? keyword;

  RangeValues? openingPriceRange;
  FilterParams({
    this.order = SearchOrder.NEW,
    this.keywordTEC,
    this.keyword,
    this.categories,
    this.auctionStatus,
    this.openingPriceRange,
  });

  FilterParams copyWith({
    List<CategoryEntity>? categories,
    AuctionStatusEntity? auctionStatus,
    SearchOrder? order,
    bool clearAuctionStatus = false,
    int? subCategory,
    String? keyword,
    RangeValues? openingPriceRange,
  }) {
    this.categories = categories ?? this.categories;
    this.auctionStatus = auctionStatus ?? this.auctionStatus;
    if (clearAuctionStatus == true) this.auctionStatus = null;
    this.keyword = keyword ?? this.keyword;
    this.order = order ?? this.order;
    this.openingPriceRange = openingPriceRange ?? this.openingPriceRange;

    return this;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'categoryIds': categories?.map((e) => e.id).toList(),
      'status': auctionStatus?.value,
      'order': order?.name,
      'priceFrom': openingPriceRange?.start,
      'priceTo': openingPriceRange?.end,
      'keyword': keyword?.trim(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
