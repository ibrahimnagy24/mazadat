import 'dart:developer';

import 'package:flutter/cupertino.dart';

abstract class PaginationService {
  static bool scrollListener(ScrollController controller,
      {int maxPage = 0, int currentPage = 0}) {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (maxScroll == currentScroll && maxScroll != 0.0) {
      log('>>>>>>>>>>>>>>> get into equal scroll');
      log('$maxScroll   $currentScroll');
      if (currentPage < maxPage) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

class SearchEngine {
  dynamic id;
  dynamic query;
  int? currentPage;
  int? limit, maxPages;
  bool? isLoading;
  SearchEngine(
      {this.id,
      this.query,
      this.maxPages = 1,
      this.isLoading = true,
      this.currentPage = -1,
      this.limit = 10});

  updateCurrentPage(int page) => currentPage = page;

  factory SearchEngine.fromJson(Map<String, dynamic> json) => SearchEngine(
        currentPage: json['number'],
        maxPages: json['totalPages'],
        limit: json['size'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    if (query != null && query is Map<dynamic, dynamic>) {
      data.addAll(query);
    }
    data['size'] = 1000;
    data['page'] = (currentPage! + 1);
    data.removeWhere((key, value) => value == null);
    return data;
  }

  Map<String, dynamic> toPage() {
    return {
      'limit': limit,
      'page': currentPage,
    };
  }
}
