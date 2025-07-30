import '../../../../../core/shared/entity/paggination_entity.dart';
import '../../../../../core/utils/utility.dart';
import '../../../view_wallet_history/data/model/wallet_history_model.dart';
import '../entity/view_my_wallet_entity.dart';

class ViewMyWalletModel extends ViewMyWalletEntity {
  const ViewMyWalletModel({
    required super.balance,
    required super.currancy,
    required super.lastUpdatedDate,
    required super.creationDate,
    required super.id,
    required super.walletHistory,
    required super.pagginationEntity,
  });

  factory ViewMyWalletModel.fromJson(Map<String, dynamic> json) {
    final wallet = json['WALLET'];
    final transaction = json['TRANSACTIONS'];
    return ViewMyWalletModel(
      balance: wallet['balance'],
      currancy: wallet['currency'],
      lastUpdatedDate: wallet['lastUpdateDate'],
      creationDate: wallet['creationDate'],
      id: wallet['id'],
      walletHistory: checkFromArray(transaction['content'])
          ? ((transaction['content'] as List)
              .map((e) => WalletHistoryModel.fromJson(e))
              .toList())
          : [],
      pagginationEntity: PagginationEntity(
        currentPage: transaction['number'],
        lastPage: transaction['totalPages'],
        total: transaction['totalElements'],
      ),
    );
  }
}
