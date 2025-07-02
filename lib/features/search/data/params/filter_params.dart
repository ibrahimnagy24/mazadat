class FilterParams {
  int? category;
  int? subCategory;
  String? keyword;
  FilterParams({this.keyword, this.category, this.subCategory});

  FilterParams copyWith({
    int? category,
    int? subCategory,
    String? keyword,
    bool clearCategory = false,
    bool clearSubCategory = false,
    bool clearKeyword = false,
  }) {
    if (clearCategory = true) this.category = null;
    if (clearSubCategory = true) this.subCategory = null;
    if (clearKeyword = true) this.keyword = null;
    this.category = category ?? this.category;
    this.subCategory = subCategory ?? this.subCategory;
    this.keyword = keyword ?? this.keyword;

    return this;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'category': category,
      'subCategory': subCategory,
      'keyword': keyword?.trim(),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
