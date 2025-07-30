import 'package:equatable/equatable.dart';

import '../../../../../core/shared/entity/paggination_entity.dart';
import '../../../view_wallet_history/data/entity/wallet_history_entity.dart';

class ViewMyWalletEntity extends Equatable {
  final dynamic balance;
  final dynamic currancy;
  final String lastUpdatedDate;
  final String creationDate;
  final int id;
  final List<WalletHistoryEntity> walletHistory;
  final PagginationEntity pagginationEntity;
  const ViewMyWalletEntity({
    required this.balance,
    required this.currancy,
    required this.lastUpdatedDate,
    required this.creationDate,
    required this.id,
    required this.walletHistory,
    required this.pagginationEntity,
  });

  @override
  List<Object?> get props => [
        balance,
        currancy,
        lastUpdatedDate,
        creationDate,
        id,
        walletHistory,
        pagginationEntity,
      ];
}
