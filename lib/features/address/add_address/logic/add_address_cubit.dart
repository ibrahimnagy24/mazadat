import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../../../core/utils/utility.dart';
import '../../addresses/data/model/addresses_model.dart';
import '../../address_types/data/entity/address_type_entity.dart';
import '../data/entity/address_entity.dart';
import '../data/enum/address_type_enum.dart';
import '../data/repository/add_address_repo.dart';
import 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());
//---------------------------------VARIABLES----------------------------------//

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddressTypeEnum selectedType = AddressTypeEnum.home;
  AddressTypeEntity? selectedAddressTypeEntity;

  final entity = BehaviorSubject<AddressEntity?>();
  Function(AddressEntity?) get updateEntity => (AddressEntity? newEntity) {
        cprint(
            '🔍 [CUBIT DEBUG] Updating entity with region: ${newEntity?.region?.id} (${newEntity?.region?.name})');
        cprint('🔍 [CUBIT DEBUG] Entity toJson: ${newEntity?.toJson()}');
        entity.sink.add(newEntity);
      };
  Stream<AddressEntity?> get entityStream => entity.stream.asBroadcastStream();
  ScrollController controller = ScrollController();
//---------------------------------FUNCTIONS----------------------------------//

  void updateSelectedType(AddressTypeEnum type) {
    selectedType = type;
    // Also update the entity to keep them in sync
    final currentEntity = entity.valueOrNull;
    if (currentEntity != null) {
      updateEntity(currentEntity.copyWith(selectedAddressType: type));
    }
  }

  void updateSelectedAddressTypeEntity(AddressTypeEntity? type) {
    selectedAddressTypeEntity = type;
    // Also update the entity to keep them in sync
    final currentEntity = entity.valueOrNull;
    if (currentEntity != null) {
      updateEntity(currentEntity.copyWith(selectedAddressTypeEntity: type));
    }
  }

  AddressTypeEnum getSelectedType() => selectedType;
  AddressTypeEntity? getSelectedAddressTypeEntity() =>
      selectedAddressTypeEntity;

  bool isBodyValid() {
    cprint(
        '🔍 [VALIDATION DEBUG] Current entity region: ${entity.valueOrNull?.region?.id}');
    log('==>Address ${entity.valueOrNull?.toJson()}');
    if (entity.valueOrNull?.addressType == null) {
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    entity.close();
    controller.dispose();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> addAddressStatesHandled() async {
    emit(const AddAddressLoading());
    final response = await AddAddressRepo.addAddress(AddressEntity(
      id: entity.valueOrNull?.id,
      addressType: entity.valueOrNull?.addressType,
      selectedAddressType: selectedType,
      region: entity.valueOrNull?.region,
      city: entity.valueOrNull?.city,
      district: entity.valueOrNull?.district,
      addressTEC: entity.valueOrNull?.addressTEC,
      phoneTEC: entity.valueOrNull?.phoneTEC,
      isDefault: entity.valueOrNull?.isDefault,
    ));
    response.fold((failure) {
      return emit(AddAddressError(failure));
    }, (success) async {
      return emit(const AddAddressSuccess());
    });
  }

  Future<void> initAddAddress(AddressModel? address) async {
    updateEntity(AddressEntity(
      id: address?.id,
      addressType: address?.addressType,
      selectedAddressType: address?.selectedAddressType,
      region: address?.region,
      city: address?.city,
      district: address?.district,
      addressTEC: TextEditingController(text: address?.desc),
      phoneTEC: TextEditingController(text: address?.phone),
      isDefault: address?.isDefault == true,
    ));
    return emit(AddAddressInitial());
  }
}
