import 'notification_entity.dart';
import 'pageable_entity.dart';

class NotificationsResponseEntity {
  final List<NotificationEntity> content;
  final PageableEntity pageable;
  final bool last;
  final int totalElements;
  final int totalPages;
  final int size;
  final int number;
  final SortEntity sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  const NotificationsResponseEntity({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
}
