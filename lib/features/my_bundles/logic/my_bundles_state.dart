import '../../../core/shared/entity/error_entity.dart';
import '../../bundles/data/entity/bundle_entity.dart';

sealed class MyBundlesState {
  const MyBundlesState();
}

final class MyBundlesInitial extends MyBundlesState {
  const MyBundlesInitial();
}

final class MyBundlesEmpty extends MyBundlesState {
  const MyBundlesEmpty();
}

class MyBundlesLoading extends MyBundlesState {
  const MyBundlesLoading();
}

class MyBundlesSuccess extends MyBundlesState {
  final List<BundleEntity> bundles;
  final bool isLoading;
  const MyBundlesSuccess({required this.bundles, this.isLoading = false});
}

class MyBundlesError extends MyBundlesState {
  final ErrorEntity error;
  const MyBundlesError(this.error);
}
