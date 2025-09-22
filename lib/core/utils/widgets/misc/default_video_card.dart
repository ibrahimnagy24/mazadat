import 'dart:developer';
import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

import '../../../theme/colors/styles.dart';
import '../../extensions/media_query_helper.dart';

class DefaultVideoCard extends StatefulWidget {
  final String? videoUrl;
  final File? videoFile;
  final double height;
  final double? width;

  final double radius;
  final bool play;
  final Function()? onTap;

  const DefaultVideoCard(
      {super.key,
      this.videoUrl,
      this.videoFile,
      this.height = 250,
      this.width,
      this.radius = 15,
      this.play = true,
      this.onTap});

  @override
  VideoCardState createState() => VideoCardState();
}

class VideoCardState extends State<DefaultVideoCard> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile != null) {
      _videoController = VideoPlayerController.file(widget.videoFile!);
    } else {
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl ??''));
    }

    _initializeVideoPlayerFuture =
        _videoController.initialize().catchError((e) {
      log('===> $e');
    });
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap?.call();
              if (widget.play) {
                setState(
                  () {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    } else {
                      _videoController.play();
                    }
                  },
                );
              }
            },
            child: Container(
              height: widget.height,
              width: widget.width ?? MediaQueryHelper.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_videoController.value.hasError) {
                      return Container(
                        color: Colors.black,
                        child: const Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(widget.radius),
                      child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          if (!_videoController.value.isPlaying)
            Center(
              child: IconButton(
                onPressed: () {
                  if (widget.play) {
                    setState(
                      () {
                        if (_videoController.value.isPlaying) {
                          _videoController.pause();
                        } else {
                          _videoController.play();
                        }
                      },
                    );
                  }
                },
                icon: Icon(
                  Icons.play_circle,
                  size: (widget.width ?? MediaQueryHelper.width) / 4,
                  color: AppColors.kGeryText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
