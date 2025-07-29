import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

enum WalletHistoryStatus { pending, completed, failed, cancelled }

class WalletHistoryEntity extends Equatable {
  final int id;
  final WalletHistoryType type;
  final String title;
  final dynamic amount;
  final String date;
  final WalletHistoryStatus status;

  const WalletHistoryEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
    this.status = WalletHistoryStatus.completed,
  });

  @override
  List<Object?> get props => [id, type, title, amount, date, status];
}
