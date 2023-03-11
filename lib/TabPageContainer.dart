import 'package:flutter/material.dart';

/// _TabPageContainer 实现tab页面懒加载及状态保存
class TabPageContainer extends StatefulWidget {
  final List<Widget> children;
  final int currentIndex;

  const TabPageContainer(
      {Key? key, required this.children, required this.currentIndex})
      : assert(currentIndex >= 0),
        super(key: key);

  @override
  State<TabPageContainer> createState() => _TabPageContainerState();
}

class _TabPageContainerState extends State<TabPageContainer> {
  final initMap = <int, bool>{};

  @override
  void initState() {
    super.initState();
    initMap[0] = true;
  }

  List<Widget> createChildren() {
    final result = <Widget>[];
    for (var i = 0; i < widget.children.length; ++i) {
      final w = widget.children[i];
      if (initMap[i] == true) {
        result.add(w);
      } else {
        result.add(Container());
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.currentIndex,
      children: createChildren(),
    );
  }

  @override
  void didUpdateWidget(covariant TabPageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      initMap[widget.currentIndex] = true;
      setState(() {});
    }
  }
}
