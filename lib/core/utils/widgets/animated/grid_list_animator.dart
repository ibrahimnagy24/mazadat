import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../extensions/extensions.dart';

class GridListAnimator extends StatelessWidget {
  final List<Widget>? data;
  final int? crossAxisCount;
  final bool? neverScrollView;
  final double? aspectRatio;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding ;

  const GridListAnimator(
      {super.key,
      this.data,
      this.controller,
      this.padding,
      this.crossAxisCount,
      this.aspectRatio,
      this.neverScrollView = false});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: controller,
      padding: padding?? const EdgeInsets.only(top: 5),
      crossAxisCount: crossAxisCount ?? 2,
      physics: neverScrollView!
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      childAspectRatio: aspectRatio ?? 1.7,
      mainAxisSpacing: 16.w,
      crossAxisSpacing: 16.w,
      children: List.generate(
        data!.length,
        (int index) {
          return AnimationConfiguration.staggeredGrid(
              columnCount: crossAxisCount ?? 2,
              position: index,
              duration: const Duration(milliseconds: 375),
              child:
                  ScaleAnimation(child: FadeInAnimation(child: data![index])));
        },
      ),
    );
  }
}
