import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/entity/error_entity.dart';
import '../data/entity/age_entity.dart';
import '../data/repo/age_repo.dart';
part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit() : super(BankStart());
//---------------------------------VARIABLES----------------------------------//
  List<BankEntity>? _allBanks;

//---------------------------------FUNCTIONS----------------------------------//
  List<BankEntity>? get allBanks => _allBanks;

  Future<void> citiesStatesHandled() async {
    emit(BankLoading());
    final response = await BanksRepo.getBanks();
    response.fold((failure) {
      return emit(BankError(failure));
    }, (success) async {
      _allBanks = success;
      if (_allBanks != null && _allBanks!.isNotEmpty) {
        return emit(BankDone(success));
      } else {
        return emit(BankEmpty());
      }
    });
  }
}
