import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/navigation/custom_navigation.dart';
import '../../../core/utils/widgets/dialogs/loading_dialog.dart';
import '../data/params/toggle_favourites_params.dart';
import '../data/repo/favourites_repo.dart';
import 'toggle_favourite_state.dart';

class ToggleFavouriteAuctionCubit extends Cubit<ToggleFavouriteState> {
  ToggleFavouriteAuctionCubit() : super(const ToggleFavouriteInitial());

  Future<void> toggleFavouriteAuction(ToggleFavouritesParams params) async {
    try {
      loadingDialog();

      final response = await FavouritesRepo.toggleFavoriteAuction(params);
      CustomNavigator.pop();

      response.fold((fail) {
        return showErrorSnackBar(fail.message);
      }, (success) {
        params.onSuccess?.call();
        showSuccessSnackBar(success.data['MESSAGE']);
        return emit(const ToggleFavouriteSuccess());
      });
    } catch (e) {
      CustomNavigator.pop();
      return showErrorSnackBar(e.toString());
    }
  }
}
