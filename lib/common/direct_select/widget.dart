import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'overlay.dart';
import 'scroll_controller.dart';

class DirectSelect extends StatefulWidget {
  /// Widget child you'll tap to display the Selection List.
  final Widget? child;

  /// List of Widgets to display after you tap the child.
  final List<Widget>? items;

  /// Listener when you select any item from the Selection List.
  final ValueChanged<int?>? onSelectedItemChanged;

  /// Height of each Item of the Selection List.
  final double? itemExtent;

  /// Amount of magnification when showing the selected item in the overlay.
  final double? itemMagnification;

  /// Selected index of your selection list.
  final int? selectedIndex;

  /// Color of the background, [Colors.white] by default.
  final Color? backgroundColor;

  /// Color of the selection background, [Colors.black12] by default.
  final Color? selectionColor;

  /// Show select in full screen mode. True by default.
  final bool? fullScreenOverlay;

  /// Width of the overlay, if [fullScreenOverlay] set to false
  final double width;

  /// Height of the overlay, if [fullScreenOverlay] set to false
  final double height;

  const DirectSelect({
    required this.child,
    required this.items,
    required this.onSelectedItemChanged,
    required this.itemExtent,
    this.itemMagnification = 1.15,
    this.selectedIndex = 0,
    this.backgroundColor = const Color(0x50FFFFFF),
    this.selectionColor = const Color(0x50000000),
    this.fullScreenOverlay = true,
    this.width = 200,
    this.height = 300,
    Key? key,
  }) : super(key: key);

  @override
  DirectSelectState createState() => DirectSelectState();
}

class DirectSelectState<T extends DirectSelect> extends State<T> {
  ModFixedExtentScrollController? _controller;
  GlobalKey _key = GlobalKey();
  GlobalKey<MySelectionOverlayState>? _keyOverlay;
  OverlayEntry? _overlayEntry;
  Offset? tapCoords;

  int? _currentIndex;

  @override
  void initState() {
    _keyOverlay = new GlobalKey();
    _currentIndex = widget.selectedIndex;
    _controller = ModFixedExtentScrollController(widget.selectedIndex!);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DirectSelect oldWidget) {
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _currentIndex = widget.selectedIndex;
      _controller!.dispose();
      _controller = ModFixedExtentScrollController(widget.selectedIndex!);
    }
    super.didUpdateWidget(oldWidget as T);
  }

  void notifySelectedItem() {
    widget.onSelectedItemChanged!(_currentIndex);
  }

  Future<void> createOverlay(TapDownDetails tapDetails) async {
    if (mounted) {
      tapCoords = tapDetails.globalPosition;
      OverlayState? overlayState = Overlay.of(context);
      if (overlayState != null) {
        _overlayEntry =
            OverlayEntry(builder: (_) => overlayWidget(_keyOverlay));
        overlayState.insert(_overlayEntry!);
      }
    }
  }

  Future<void> removeOverlay([TapUpDetails? details]) async {
    if (mounted) {
      if (details?.globalPosition.dx == tapCoords?.dx &&
          details?.globalPosition.dy == tapCoords?.dy) {
        Timer(Duration(milliseconds: 300), () {
          _keyOverlay?.currentState?.reverse(_overlayEntry);
          tapCoords = null;
        });
      }
      final currentState = _keyOverlay?.currentState;

      if (currentState != null) {
        currentState.reverse(_overlayEntry);
      }
      notifySelectedItem();
    }
  }

  Widget overlayWidget([Key? key]) {
    try {
      final RenderBox box =
          _key.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final posY = position.dy + (box.size.height / 2) - (widget.height / 2);
      final posX = position.dx + (box.size.width / 2) - (widget.width / 2);

      return MySelectionOverlay(
        key: key,
        top: posY,
        left: posX,
        width: widget.width,
        height: widget.height,
        backgroundColor: widget.backgroundColor,
        child: MySelectionList(
          itemExtent: widget.itemExtent,
          itemMagnification: widget.itemMagnification,
          childCount: widget.items != null ? widget.items!.length : 0,
          selectionColor: widget.selectionColor,
          onItemChanged: (index) {
            _currentIndex = index;
          },
          onItemSelected: () => null,
          builder: (context, index) {
            if (widget.items != null) {
              return widget.items![index];
            }
            return const SizedBox.shrink();
          },
          controller: _controller,
        ),
      );
    } catch (e) {
      print(e);
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () => null,
      onTapDown: (details) => createOverlay(details),
      onTapUp: (details) => removeOverlay(details),
      onVerticalDragEnd: (_) => removeOverlay(),
      onHorizontalDragEnd: (_) => removeOverlay(),
      onVerticalDragUpdate: (details) => _controller!.hasScrollPositions
          ? _controller!.jumpTo(_controller!.offset - details.primaryDelta!)
          : null,
      child: Container(
        key: _key,
        child: widget.child,
      ),
    );
  }
}
