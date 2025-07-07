import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/shared/entity/error_entity.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/repository/delete_account_repo.dart';
import 'delete_account_state.dart';

class CheckDeleteAccountCubit extends Cubit<DeleteAccountState> {
  CheckDeleteAccountCubit() : super(DeleteAccountInitial());

//----------------------------------REQUEST-----------------------------------//
  Future<void> checkDeleteAccountStatesHandled() async {
    loadingDialog();
    final response = await DeleteAccountRepo.checkDeleteAccount();
    CustomNavigator.pop();
    response.fold((failure) {
      return emit(DeleteAccountError(failure));
    }, (success) async {
      if (success.statusCode == 200) {
        return emit(const DeleteAccountSuccess());
      } else {
        return emit(
          DeleteAccountError(
            ErrorEntity(
              statusCode: success.statusCode ?? 404,
              message: success.data?['message'],
              errors: const [],
            ),
          ),
        );
      }
    });
  }
}
