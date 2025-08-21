// Simple service locator for responsive utilities
import 'responsive/responsive_service.dart';
import 'responsive/flutter_responsive_impl.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  void registerServices() {
    _services[ResponsiveService] = FlutterResponsiveImpl();
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T is not registered');
    }
    return service as T;
  }
}

class Services {
  static ResponsiveService get responsive => ServiceLocator().get<ResponsiveService>();
}
