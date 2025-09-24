import 'package:flutter/material.dart';
import '../../../address_types/data/entity/address_type_entity.dart';
import '../../../city/data/entity/city_entity.dart';
import '../../../districts/data/entity/district_entity.dart';
import '../../../regions/data/entity/region_entity.dart';
import '../enum/address_type_enum.dart';

class AddressEntity {
  int? id;
  AddressTypeEntity? addressType;
  AddressTypeEnum? selectedAddressType;
  RegionEntity? region;
  CityEntity? city;
  DistrictEntity? district;
  TextEditingController? addressTEC, phoneTEC;
  bool? isDefault, clearCity, clearDistrict;

  AddressEntity({
    this.id,
    this.addressType,
    this.selectedAddressType,
    this.region,
    this.city,
    this.district,
    this.addressTEC,
    this.phoneTEC,
    this.clearCity,
    this.clearDistrict,
    this.isDefault,
  });

  AddressEntity copyWith({
    int? id,
    AddressTypeEntity? addressType,
    AddressTypeEnum? selectedAddressType,
    AddressTypeEntity? selectedAddressTypeEntity,
    RegionEntity? region,
    CityEntity? city,
    DistrictEntity? district,
    bool? clearCity,
    bool? clearDistrict,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      addressType: addressType ?? selectedAddressTypeEntity ?? this.addressType,
      selectedAddressType: selectedAddressType ?? this.selectedAddressType,
      region: region ?? this.region,
      city: clearCity == true ? null : (city ?? this.city),
      district: clearDistrict == true ? null : (district ?? this.district),
      addressTEC: addressTEC, // Keep the same controllers
      phoneTEC: phoneTEC, // Keep the same controllers
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      if (id != null) 'id': id,
      'type': addressType?.id,
      'regionId': region?.id,
      'cityId': city?.id,
      'districtId': district?.id,
      'desc': addressTEC?.text.trim(),
      'phone': phoneTEC?.text.trim(),
      'isDefault': isDefault == true ? '1' : '0',
    };
    // map.removeWhere((key, value) => value == null);
    return map;
  }
}
