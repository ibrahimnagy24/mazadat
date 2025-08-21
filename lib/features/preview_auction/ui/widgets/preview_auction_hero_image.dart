import 'package:flutter/material.dart';
import '../../../../core/utils/extensions/extensions.dart';
import '../../data/model/auction_details_model.dart';
import '../../data/params/auction_details_route_params.dart';

class PreviewAuctionHeroImage extends StatefulWidget {
  const PreviewAuctionHeroImage({
    super.key,
    required this.animationController,
    required this.routeParams,
    required this.imageUrls,
  });

  final AnimationController animationController;
  final PreviewAuctionRouteParams routeParams;
  final List<AttachmentModel> imageUrls;

  @override
  State<PreviewAuctionHeroImage> createState() => _PreviewAuctionHeroImageState();
}

class _PreviewAuctionHeroImageState extends State<PreviewAuctionHeroImage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls.where((attachment) => !attachment.isVideo).toList();
    
    if (images.isEmpty) {
      return Container(
        height: 400.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: widget.routeParams.primaryImage.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(widget.routeParams.primaryImage),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: widget.routeParams.primaryImage.isEmpty
            ? const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              )
            : null,
      );
    }

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (widget.animationController.value * 0.05),
          child: SizedBox(
            height: 400.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images[index].url ?? ''),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            // Handle image loading error
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 20.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
