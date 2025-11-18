import '../../../../../core/services/pagination/pagination_service.dart';
import '../../../address_types/data/model/address_type_model.dart';
import '../../../city/data/model/city_model.dart';
import '../../../districts/data/model/districts_model.dart';
import '../../../regions/data/model/regions_model.dart';
import '../../../add_address/data/enum/address_type_enum.dart';

class AddressesModel {
  List<AddressModel>? content;
  SearchEngine? pageable;

  AddressesModel({this.content, this.pageable});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <AddressModel>[];
      json['content'].forEach((v) {
        content!.add(AddressModel.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? SearchEngine.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    return data;
  }
}

class AddressModel {
  int? id;
  AddressTypeModel? addressType;
  AddressTypeEnum? selectedAddressType;
  String? desc;
  String? street;
  String? phone;
  RegionModel? region;
  CityModel? city;
  DistrictModel? district;
  bool? isDefault;
  String? creationDate;
  String? lastUpdateDate;

  Function()? onSuccess;

  AddressModel(
      {this.id,
      this.addressType,
      this.selectedAddressType,
      this.desc,
      this.street,
      this.phone,
      this.region,
      this.city,
      this.district,
      this.isDefault,
      this.creationDate,
      this.lastUpdateDate,
      this.onSuccess});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressType = json['addressType'] != null
        ? AddressTypeModel.fromJson(json['addressType'])
        : null;
    selectedAddressType = json['addressType'] != null
        ? AddressTypeEnum.values.firstWhere(
            (e) => e.name == json['addressType'],
            orElse: () => AddressTypeEnum.home,
          )
        : null;
    desc = json['desc'];
    street = json['street'];
    phone = json['phone'];
    region =
        json['region'] != null ? RegionModel.fromJson(json['region']) : null;
    city = json['city'] != null ? CityModel.fromJson(json['city']) : null;
    district = json['district'] != null
        ? DistrictModel.fromJson(json['district'])
        : null;
    isDefault = int.parse(json['isDefault']?.toString() ?? '0') == 1;
    creationDate = json['creationDate'];
    lastUpdateDate = json['lastUpdateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (addressType != null) {
      data['addressType'] = addressType!.toJson();
    }
    data['desc'] = desc;
    data['street'] = street;
    data['phone'] = phone;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    data['isDefault'] = isDefault;
    data['creationDate'] = creationDate;
    data['lastUpdateDate'] = lastUpdateDate;
    return data;
  }
}
