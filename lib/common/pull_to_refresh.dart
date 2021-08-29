import 'dart:io';

import 'package:flutter/cupertino.dart';

class PullToRefresh extends StatefulWidget {
  final Future Function() onRefresh;
  final Widget child;
  final Widget? header;

  const PullToRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.header,
  }) : super(key: key);

  @override
  _PullToRefreshState createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  late final List<Widget>slivers;

  @override
  void initState() {
    slivers = [
      CupertinoSliverRefreshControl(
        refreshTriggerPullDistance: 150.0,
        refreshIndicatorExtent: 60.0,
        onRefresh: widget.onRefresh,
      ),
      widget.child
    ];

    if (widget.header != null) slivers.insert(0, widget.header!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iOSIndicator() : _androidIndicator();
  }

  Widget _iOSIndicator() {
    return CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: slivers);
  }

  Widget _androidIndicator() {
    return Container();
  }
}
