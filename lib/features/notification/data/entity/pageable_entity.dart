class PageableEntity {
  final int pageNumber;
  final int pageSize;
  final SortEntity sort;
  final int offset;
  final bool paged;
  final bool unpaged;

  const PageableEntity({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });
}

class SortEntity {
  final bool sorted;
  final bool empty;
  final bool unsorted;

  const SortEntity({
    required this.sorted,
    required this.empty,
    required this.unsorted,
  });
}
