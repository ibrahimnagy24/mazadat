import 'package:flutter/material.dart';

typedef ShouldRebuildFunction<T extends Widget> = bool Function(T oldWidget, T newWidget);

class ShouldRebuild<T extends Widget> extends StatefulWidget {
  final T child;
  final ShouldRebuildFunction<T>? shouldRebuild;

  const ShouldRebuild({
    super.key,
    required this.child,
    this.shouldRebuild,
  });

  @override
  State<ShouldRebuild<T>> createState() => _ShouldRebuildState<T>();
}

class _ShouldRebuildState<T extends Widget> extends State<ShouldRebuild<T>> {
  late T _currentChild;

  @override
  void initState() {
    super.initState();
    _currentChild = widget.child;
  }

  @override
  void didUpdateWidget(covariant ShouldRebuild<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldRebuild = widget.shouldRebuild;
    if (shouldRebuild == null || shouldRebuild(_currentChild, widget.child)) {
      _currentChild = widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentChild;
  }
}
