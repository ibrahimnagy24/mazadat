import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/utility.dart';

class BlocObserverService extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    cprint('@BLOC_OBSERVER:: onCreate bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    cprint(
        '@BLOC_OBSERVER:: onEvent bloc: ${bloc.runtimeType} ** event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    cprint(
        '@BLOC_OBSERVER:: onChange bloc: ${bloc.runtimeType} ** change: $change');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    cprint(
        '@BLOC_OBSERVER:: onTransition bloc: ${bloc.runtimeType} ** transition: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    cprint(
        '@BLOC_OBSERVER:: onError bloc: ${bloc.runtimeType} ** error: $error ** stackTrace: $stackTrace');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    cprint('@BLOC_OBSERVER:: onClose bloc: ${bloc.runtimeType}');
  }
}
