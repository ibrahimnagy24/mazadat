import '../entities/message_type_entity.dart';

class MessageTypeModel extends MessageTypeEntity {
  const MessageTypeModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.status,
    required super.sequence,
    required super.createdBy,
    required super.creationDate,
    required super.lastUpdatedBy,
    required super.lastUpdateDate,
    required super.name,
  });

  factory MessageTypeModel.fromJson(Map<String, dynamic> json) =>
      MessageTypeModel(
        id: json['id'],
        nameEn: json['nameEn'],
        nameAr: json['nameAr'],
        status: json['status'],
        sequence: json['sequence'],
        createdBy: json['createdBy'],
        creationDate: json['creationDate'],
        lastUpdatedBy: json['lastUpdatedBy'],
        lastUpdateDate: json['lastUpdateDate'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nameEn'] = nameEn;
    data['nameAr'] = nameAr;
    data['status'] = status;
    data['sequence'] = sequence;
    data['createdBy'] = createdBy;
    data['creationDate'] = creationDate;
    data['lastUpdatedBy'] = lastUpdatedBy;
    data['lastUpdateDate'] = lastUpdateDate;
    data['name'] = name;
    return data;
  }
}
