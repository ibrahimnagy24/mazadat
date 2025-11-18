import 'package:equatable/equatable.dart';

class MessageTypeEntity extends Equatable {
  const MessageTypeEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.status,
    required this.sequence,
    required this.createdBy,
    required this.creationDate,
    required this.lastUpdatedBy,
    required this.lastUpdateDate,
    required this.name,
  });

  final int id;
  final String nameEn;
  final String nameAr;
  final String status;
  final String sequence;
  final String createdBy;
  final String creationDate;
  final String lastUpdatedBy;
  final String lastUpdateDate;
  final String name;

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        status,
        sequence,
        createdBy,
        creationDate,
        lastUpdatedBy,
        lastUpdateDate,
        name,
      ];
}
