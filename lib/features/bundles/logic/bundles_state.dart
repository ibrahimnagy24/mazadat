import '../../../core/shared/entity/error_entity.dart';
import '../data/entity/bundle_entity.dart';

sealed class BundlesState {
  const BundlesState();
}

final class BundlesInitial extends BundlesState {
  const BundlesInitial();
}

class BundlesLoading extends BundlesState {
  const BundlesLoading();
}

class BundlesSuccess extends BundlesState {
  final List<BundleEntity> bundles;
  const BundlesSuccess(this.bundles);
}

class BundlesError extends BundlesState {
  final ErrorEntity error;
  const BundlesError(this.error);
}
