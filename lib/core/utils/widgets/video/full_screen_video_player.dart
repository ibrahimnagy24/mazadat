import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../../theme/colors/styles.dart';
import '../../../navigation/custom_navigation.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String? title;

  const FullScreenVideoPlayer({
    super.key,
    required this.videoUrl,
    this.title,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isControlsVisible = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    
    // Set landscape orientation for full screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Hide system UI for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _controller.initialize().catchError((e) {
      log('Video initialization error: $e');
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });

    // Auto-hide controls after 3 seconds
    _hideControlsAfterDelay();
  }

  @override
  void dispose() {
    _controller.dispose();
    
    // Restore system UI and orientation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    super.dispose();
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
    
    if (_isControlsVisible) {
      _hideControlsAfterDelay();
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
        _hideControlsAfterDelay();
      }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Video Player
            Center(
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_controller.value.hasError) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 64,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Failed to load video',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Error loading video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),

            // Controls Overlay
            if (_isControlsVisible)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),

            // Top Controls
            if (_isControlsVisible)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => CustomNavigator.pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            widget.title ?? 'Video Player',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Center Play/Pause Button
            if (_isControlsVisible)
              Center(
                child: IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),

            // Bottom Controls
            if (_isControlsVisible)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Progress Bar
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: AppColors.kPrimary,
                            bufferedColor: Colors.white30,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Time and Controls
                        Row(
                          children: [
                            // Current Time
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder: (context, VideoPlayerValue value, child) {
                                return Text(
                                  _formatDuration(value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                            const Spacer(),
                            // Play/Pause Button
                            IconButton(
                              onPressed: _togglePlayPause,
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const Spacer(),
                            // Total Duration
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder: (context, VideoPlayerValue value, child) {
                                return Text(
                                  _formatDuration(value.duration),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
