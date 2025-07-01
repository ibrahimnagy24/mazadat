import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/utils/enums/enums.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    updateCategoryType(CategoryTypes.auction);
    updateListing(true);
  }

  final listing = BehaviorSubject<bool>();
  Function(bool) get updateListing => listing.sink.add;
  Stream<bool> get listingStream => listing.stream.asBroadcastStream();

  final categoryType = BehaviorSubject<CategoryTypes>();
  Function(CategoryTypes) get updateCategoryType => categoryType.sink.add;
  Stream<CategoryTypes> get categoryTypeStream =>
      categoryType.stream.asBroadcastStream();
}
