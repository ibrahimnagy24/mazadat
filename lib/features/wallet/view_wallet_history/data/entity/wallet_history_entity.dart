import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/enums.dart';

class WalletHistoryEntity extends Equatable {
  final int id;
  final WalletHistoryType type;
  final String title;
  final dynamic amount;
  final String date;
  final String message;

  const WalletHistoryEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
    required this.message,
  });

  @override
  List<Object?> get props => [id, type, title, amount, date, message];
}
