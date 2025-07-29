import 'package:flutter/material.dart';
import '../../../selectors/address_types/data/model/address_type_model.dart';
import '../../../selectors/city/data/model/city_model.dart';
import '../../../selectors/districts/data/model/districts_model.dart';
import '../../../selectors/regions/data/model/regions_model.dart';

class AddressEntity {
  int? id;
  AddressTypeModel? addressType;
  RegionModel? region;
  CityModel? city;
  DistrictModel? district;
  TextEditingController? addressTEC, phoneTEC;
  bool? isDefault, clearCity, clearDistrict;

  AddressEntity({
    this.id,
    this.addressType,
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
    AddressTypeModel? addressType,
    RegionModel? region,
    CityModel? city,
    DistrictModel? district,
    bool? clearCity,
    bool? clearDistrict,
    bool? isDefault,
  }) {
    this.id = id ?? this.id;
    this.addressType = addressType ?? this.addressType;
    this.region = region ?? this.region;
    this.city = city ?? this.city;
    this.district = district ?? this.district;
    if (clearCity == true) this.city = null;
    if (clearDistrict == true) this.district = null;
    this.isDefault = isDefault ?? this.isDefault;

    return this;
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
