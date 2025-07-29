import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../addresses/data/model/addresses_model.dart';
import '../data/entity/address_entity.dart';
import '../data/repository/add_address_repo.dart';
import 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());
//---------------------------------VARIABLES----------------------------------//

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final entity = BehaviorSubject<AddressEntity?>();
  Function(AddressEntity?) get updateEntity => entity.sink.add;
  Stream<AddressEntity?> get entityStream => entity.stream.asBroadcastStream();

//---------------------------------FUNCTIONS----------------------------------//

  bool isBodyValid() {
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
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> addAddressStatesHandled() async {
    emit(const AddAddressLoading());
    final response = await AddAddressRepo.addAddress(entity.valueOrNull!);
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
