import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/bundle_entity.dart';

sealed class BundlesState {
  const BundlesState();
}

final class BundlesInitial extends BundlesState {
  const BundlesInitial();
}

final class BundlesEmpty extends BundlesState {
  const BundlesEmpty();
}

class BundlesLoading extends BundlesState {
  const BundlesLoading();
}

class BundlesSuccess extends BundlesState {
  final List<BundleEntity> bundles;
  final bool isLoading;
  const BundlesSuccess({required this.bundles, this.isLoading = false});
}

class BundlesError extends BundlesState {
  final ErrorEntity error;
  const BundlesError(this.error);
}
