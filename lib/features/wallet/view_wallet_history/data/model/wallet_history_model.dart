import '../entity/wallet_history_entity.dart';
import '../../../../../core/utils/enums/enums.dart';

class WalletHistoryModel extends WalletHistoryEntity {
  const WalletHistoryModel({
    required super.amount,
    required super.date,
    required super.id,
    required super.title,
    required super.type,
    required super.message,
  });

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    return WalletHistoryModel(
      amount: json['amount'],
      date: json['lastUpdateDate'],
      id: json['id'],
      title: json['title'] ?? _getTitleFromType(json['type']),
      type: _parseWalletHistoryType(json['type']),
      message: json['message'],
    );
  }

  static WalletHistoryType _parseWalletHistoryType(dynamic type) {
    if (type is String) {
      if (type.toLowerCase() == 'RECHARGE_BALANCE') {
        return WalletHistoryType.deposit;
      }
      if (type.toLowerCase() == 'WITHDRAW_BALANCE') {
        return WalletHistoryType.withdraw;
      }
    }
    return WalletHistoryType.deposit;
  }

  static String _getTitleFromType(dynamic type) {
    final walletType = _parseWalletHistoryType(type);
    return walletType == WalletHistoryType.deposit
        ? 'Recharge Balance'
        : 'Withdraw Balance';
  }
}
