import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/services/pagination/pagination_service.dart';
import '../../bundles/data/entity/bundle_entity.dart';
import '../../bundles/data/model/bundles_model.dart';
import '../data/repo/my_bundles_repo.dart';
import 'my_bundles_state.dart';

class MyBundlesCubit extends Cubit<MyBundlesState> {
  MyBundlesCubit() : super(const MyBundlesInitial()) {
    controller = ScrollController();
    keywordTEC = TextEditingController();
    customScroll(controller);
    updateListing(true);

  }
//---------------------------------VARIABLES----------------------------------//

  final listing = BehaviorSubject<bool>();
  Function(bool) get updateListing => listing.sink.add;
  Stream<bool> get listingStream => listing.stream.asBroadcastStream();

  late ScrollController controller;
  late SearchEngine _engine;
  List<BundleEntity>? model;

  late TextEditingController keywordTEC;

//---------------------------------FUNCTIONS----------------------------------//
  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = PaginationService.scrollListener(controller,
          maxPage: _engine.maxPages!, currentPage: _engine.currentPage!);
      if (scroll) {
        myBundlesStatesHandled(_engine);
      }
    });
  }

//----------------------------------REQUEST-----------------------------------//
  Future<void> myBundlesStatesHandled(SearchEngine params) async {
    _engine = params;
    if (_engine.currentPage == -1) {
      model = [];
      emit(const MyBundlesLoading());
    } else {
      emit(MyBundlesSuccess(bundles: model!, isLoading: true));
    }


    _engine.query = {
      'keyword':keywordTEC.text.trim()
    };
    final response = await MyBundlesRepo.myBundles(_engine);
    response.fold((failure) {
      return emit(MyBundlesError(failure));
    }, (success) {
      BundlesModel? res = BundlesModel.fromJson(success.data);

      if (_engine.currentPage == -1) {
        model?.clear();
      }

      if (res.content != null && res.content!.isNotEmpty) {
        for (var item in res.content!) {
          model?.removeWhere((e) => e.id == item.id);
          model?.add(item);
        }
      }
      _engine.maxPages = res.pageable?.maxPages ?? 1;
      _engine.updateCurrentPage(res.pageable?.currentPage ?? 0);

      if (model != null && model!.isNotEmpty) {
        return emit(MyBundlesSuccess(bundles: model!, isLoading: false));
      } else {
        return emit(const MyBundlesEmpty());
      }
    });
  }
}
