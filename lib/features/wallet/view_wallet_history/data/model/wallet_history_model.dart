import '../entity/wallet_history_entity.dart';
import '../../../../../core/utils/enums/enums.dart';

class WalletHistoryModel extends WalletHistoryEntity {
  const WalletHistoryModel({
    required super.amount,
    required super.date,
    required super.id,
    required super.title,
    required super.type,
    super.status,
  });

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    return WalletHistoryModel(
      amount: json['amount'],
      date: json['date'],
      id: json['id'],
      title: json['title'] ?? _getTitleFromType(json['type']),
      type: _parseWalletHistoryType(json['type']),
      status: _parseWalletHistoryStatus(json['status']),
    );
  }

  static WalletHistoryType _parseWalletHistoryType(dynamic type) {
    if (type is WalletHistoryType) return type;
    if (type is String) {
      if (type.toLowerCase() == 'deposit') return WalletHistoryType.deposit;
      if (type.toLowerCase() == 'withdraw') return WalletHistoryType.withdraw;
    }
    if (type is int) {
      if (type == 0) return WalletHistoryType.deposit;
      if (type == 1) return WalletHistoryType.withdraw;
    }
    return WalletHistoryType.deposit; // Default
  }

  static WalletHistoryStatus _parseWalletHistoryStatus(dynamic status) {
    if (status is WalletHistoryStatus) return status;
    if (status is String) {
      if (status.toLowerCase() == 'pending') return WalletHistoryStatus.pending;
      if (status.toLowerCase() == 'completed') return WalletHistoryStatus.completed;
      if (status.toLowerCase() == 'failed') return WalletHistoryStatus.failed;
      if (status.toLowerCase() == 'cancelled') return WalletHistoryStatus.cancelled;
    }
    if (status is int) {
      if (status == 0) return WalletHistoryStatus.pending;
      if (status == 1) return WalletHistoryStatus.completed;
      if (status == 2) return WalletHistoryStatus.failed;
      if (status == 3) return WalletHistoryStatus.cancelled;
    }
    return WalletHistoryStatus.completed; // Default
  }

  static String _getTitleFromType(dynamic type) {
    final walletType = _parseWalletHistoryType(type);
    return walletType == WalletHistoryType.deposit ? 'Deposit' : 'Withdraw';
  }
}
