import '../entity/pageable_entity.dart';

class PageableModel extends PageableEntity {
  const PageableModel({
    required super.pageNumber,
    required super.pageSize,
    required super.sort,
    required super.offset,
    required super.paged,
    required super.unpaged,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) {
    return PageableModel(
      pageNumber: json['pageNumber'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      sort: SortModel.fromJson(json['sort'] ?? {}),
      offset: json['offset'] ?? 0,
      paged: json['paged'] ?? false,
      unpaged: json['unpaged'] ?? false,
    );
  }
}

class SortModel extends SortEntity {
  const SortModel({
    required super.sorted,
    required super.empty,
    required super.unsorted,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) {
    return SortModel(
      sorted: json['sorted'] ?? false,
      empty: json['empty'] ?? true,
      unsorted: json['unsorted'] ?? true,
    );
  }
}
