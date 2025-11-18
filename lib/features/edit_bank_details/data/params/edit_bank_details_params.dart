import 'package:equatable/equatable.dart';

class EditBankDetailsParams extends Equatable {
  const EditBankDetailsParams({
    required this.bankNumber,
    required this.ibanNumber,
    required this.commercialNumber,
    required this.bank,
  });

  final String bankNumber;
  final String ibanNumber;
  final String commercialNumber;
  final int? bank;
  Map<String, dynamic> returnedMap() {
    Map<String, dynamic> map = {
      'bankNumber': bankNumber,
      'ibanNumber': ibanNumber,
      'commericalNumber': commercialNumber,
      if (bank != null) 'bankId': bank,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  @override
  List<Object?> get props => [
        ibanNumber,
        bankNumber,
        commercialNumber,
        bank,
      ];
}
