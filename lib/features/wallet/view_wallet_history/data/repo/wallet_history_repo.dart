// import 'dart:math' as math;
// import 'package:dartz/dartz.dart';

// import '../../../../../core/services/error_handler/error_handler.dart';
// import '../../../../../core/shared/entity/error_entity.dart';
// import '../../../../../core/utils/enums/enums.dart';
// import '../entity/wallet_history_entity.dart';

// abstract class WalletHistoryRepo {
//   const WalletHistoryRepo();
//   static Future<Either<ErrorEntity, List<WalletHistoryEntity>>>
//       walletHistory() async {
//     try {
//       // final response = await Network().request(
//       //   Endpoints.walletHistory,
//       //   method: ServerMethods.GET,
//       // );
//       // final List<WalletHistoryEntity> wallets = checkFromArray(response.data)
//       //     ? (response.data['data'] as List)
//       //         .map((e) => WalletHistoryModel.fromJson(e))
//       //         .toList()
//       //     : [];
//       return Right(_getMockData());
//     } catch (error) {
//       return Left(ApiErrorHandler().handleError(error));
//     }
//   }

//   static List<WalletHistoryEntity> _getMockData() {
//     final random = math.Random();
//     final now = DateTime.now();
//     final transactions = <WalletHistoryEntity>[];

//     // Helper function to format DateTime to consistent string format
//     String formatDate(DateTime date) => date.toIso8601String();

//     // Generate 50 transactions over the past 6 months with varied types and statuses
//     for (int i = 0; i < 50; i++) {
//       final isDeposit = random.nextBool();
//       final type =
//           isDeposit ? WalletHistoryType.deposit : WalletHistoryType.withdraw;

//       // Generate random amount between 10 and 5000
//       final amount = (random.nextDouble() * 4990 + 10).toStringAsFixed(2);

//       // Generate random date within past 6 months
//       final daysAgo = random.nextInt(180);
//       final transactionDate = now.subtract(Duration(
//           days: daysAgo,
//           hours: random.nextInt(24),
//           minutes: random.nextInt(60)));

//       // Generate random status with a bias toward completed
//       final statusRoll = random.nextInt(100);

//       // Generate random title variations
//       String title;
//       if (isDeposit) {
//         final depositTypes = [
//           'Deposit via Credit Card',
//           'Bank Transfer Deposit',
//           'Promotion Credit',
//           'Refund',
//           'Auction Winnings'
//         ];
//         title = depositTypes[random.nextInt(depositTypes.length)];
//       } else {
//         final withdrawTypes = [
//           'Withdrawal to Bank',
//           'Auction Payment',
//           'Service Fee',
//           'Membership Renewal',
//           'Commission Fee'
//         ];
//         title = withdrawTypes[random.nextInt(withdrawTypes.length)];
//       }

//       transactions.add(
//         WalletHistoryEntity(
//           id: i + 1,
//           type: type,
//           date: formatDate(transactionDate),
//           amount: double.parse(amount),
//           title: title,
//           message: 'message',
//         ),
//       );
//     }

//     // Sort by date (newest first)
//     transactions.sort(
//         (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

//     return transactions;
//   }
// }
