import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 滚动视图主要由3个部分组成：Scrollable、Viewport和Sliver
/// Scrollable: 用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建的Viewport
/// Viewport: 显示的视窗，即列表的可视区域
/// Sliver: 视窗里显示的元素

class ExampleModel {
  const ExampleModel({required this.name, required this.path});

  final String name;
  final String path;
}

class ExampleList extends StatelessWidget {
  ExampleList({super.key})
      : examples = [
          const ExampleModel(name: "example01", path: '/Example01'),
          const ExampleModel(name: "stack example", path: '/StackExample')
        ];

  final List<ExampleModel> examples;

  Widget getItem(int index, BuildContext context) {
    ExampleModel model = examples[index];
    return GestureDetector(
      child: Container(
        height: 60.0,
        color: Colors.blue,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Row(children: [
          const Image(image: AssetImage('assets/singleImgs/air.png')),
          const SizedBox(
            width: 10,
          ),
          Text(model.name)
        ]),
      ),
      onTap: () => context.go(model.path),
    );
  }

  Widget list() {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: examples.length,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return getItem(index, context);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.lightGreen,
          height: 0.5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Example list')), body: list());
  }
}
