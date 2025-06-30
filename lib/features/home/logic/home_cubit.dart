import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    updateListing(true);
  }

  final listing = BehaviorSubject<bool>();
  Function(bool) get updateListing => listing.sink.add;
  Stream<bool> get listingStream => listing.stream.asBroadcastStream();


}
