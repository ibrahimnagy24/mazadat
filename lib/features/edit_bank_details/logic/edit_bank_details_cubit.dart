import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/services/cache/shared_helper.dart';
import '../../selectors/banks/data/entity/age_entity.dart';
import '../../user/data/entity/user_entity.dart';
import '../../user/logic/user_cubit.dart';
import '../data/params/edit_bank_details_params.dart';
import '../data/repository/edit_bank_details_repo.dart';
import 'edit_bank_details_state.dart';

class EditBankDetailsCubit extends Cubit<EditBankDetailsState> {
  EditBankDetailsCubit() : super(EditBankDetailsInitial()) {
    onStart();
  }
//---------------------------------VARIABLES----------------------------------//
  final TextEditingController bankNumber = TextEditingController();
  final TextEditingController ibanNumber = TextEditingController();
  final TextEditingController commercialNumber = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//---------------------------------FUNCTIONS----------------------------------//

  final bank = BehaviorSubject<BankEntity?>();
  Function(BankEntity?) get updateBank => bank.sink.add;
  Stream<BankEntity?> get bankStream => bank.stream.asBroadcastStream();

  bool isRegisterValidate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> close() {
    bankNumber.dispose();
    ibanNumber.dispose();
    commercialNumber.dispose();
    bank.close();
    return super.close();
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> editProfileStatesHandled() async {
    emit(const EditBankDetailsLoading());
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;
    final response = await EditBankDetailsRepo.editBankDetails(
      EditBankDetailsParams(
        commercialNumber: commercialNumber.text.trim(),
        bankNumber: bankNumber.text.trim(),
        ibanNumber: ibanNumber.text.trim(),
        bank: bank.valueOrNull?.id,
      ),
    );
    response.fold((failure) {

      return emit(EditBankDetailsError(failure));
    }, (success) async {
      await SharedHelper.sharedHelper?.saveUser(success);
      return emit(EditBankDetailsSuccess(success));
    });
  }

  Future<void> onStart() async {
    final UserEntity? user = CustomNavigator.navigatorState.currentContext!
        .read<UserCubit>()
        .userEntity;
    bankNumber.text = user?.bankNumber?.trim() ?? '';
    ibanNumber.text = user?.ibanNumber?.trim() ?? '';
    commercialNumber.text = user?.commericalNumber?.trim() ?? '';
    updateBank(user?.bank);
    return emit(EditBankDetailsInitial());
  }
}
