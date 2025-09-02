import '../../../core/shared/entity/error_entity.dart';
import '../data/entities/static_page_entity.dart';

class StaticPageState {
  const StaticPageState();
}

class StaticPageInitial extends StaticPageState {
  const StaticPageInitial();
}

class GetStaticPageLoading extends StaticPageState {}

class GetStaticPageSuccess extends StaticPageState {
  const GetStaticPageSuccess(this.entity);
  final StaticPageEntity entity;
}

class GetStaticPageError extends StaticPageState {
  const GetStaticPageError(this.error);
  final ErrorEntity error;
}
