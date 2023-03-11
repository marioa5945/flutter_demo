import 'dart:math' as math;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/Assets/AssetImages.dart';
import 'package:flutter_demo/Config/Routes.dart';
import 'package:flutter_demo/Customization/ViewModel/ProductListViewModel.dart';
import 'package:flutter_demo/Models/ProductModel.dart';
import 'package:provider/provider.dart';

class CustomizationScreen extends StatelessWidget {
  const CustomizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductListViewModel(),
      child: _CustomizationList(),
    );
  }
}

class _CustomizationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ProductListViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('热门产品')),
      body: _CustomizationListImg(viewModel),
    );
  }
}

class _CustomizationListImg extends StatefulWidget {
  const _CustomizationListImg(this.viewModel);
  final ProductListViewModel viewModel;
  @override
  State<_CustomizationListImg> createState() => _CustomizationListImgState();
}

class _CustomizationListImgState extends State<_CustomizationListImg> {
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = widget.viewModel.refreshController;
    // widget.viewModel.pullUp();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() {
    widget.viewModel.refresh();
  }

  void _onLoad() {
    widget.viewModel.loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListViewModel>(
      builder: (context, viewModel, child) {
        // if (viewModel.isLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }

        List<Widget> slivers = [];
        if (viewModel.photoProductList.isNotEmpty &&
            viewModel.handmadeProductList.isNotEmpty) {
          slivers = [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: _ListHeader('3D照片'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList(
                  delegate: _ProductSliverBuilderDelegate(
                      viewModel.photoProductList, 10)),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: _ListHeader('3D定制手办'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList(
                  delegate: _ProductSliverBuilderDelegate(
                      viewModel.handmadeProductList, 10)),
            ),
          ];
        } else if (viewModel.photoProductList.isNotEmpty) {
          slivers = [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: _ListHeader('3D照片'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList(
                  delegate: _ProductSliverBuilderDelegate(
                      viewModel.photoProductList, 10)),
            ),
          ];
        } else if (viewModel.handmadeProductList.isNotEmpty) {
          slivers = [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: _ListHeader('3D定制手办'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList(
                  delegate: _ProductSliverBuilderDelegate(
                      viewModel.handmadeProductList, 10)),
            ),
          ];
        }
        // return CustomScrollView(slivers: slivers);
        final themeData = Theme.of(context);
        return EasyRefresh(
          controller: _refreshController,
          refreshOnStart: true,
          refreshOnStartHeader: BuilderHeader(
            triggerOffset: 70,
            clamping: true,
            position: IndicatorPosition.above,
            processedDuration: Duration.zero,
            builder: (context, state) {
              if (state.mode == IndicatorMode.inactive ||
                  state.mode == IndicatorMode.done) {
                return const SizedBox();
              }
              return Container(
                padding: const EdgeInsets.only(bottom: 100),
                width: double.infinity,
                height: state.viewportDimension,
                alignment: Alignment.center,
                child: SpinKitDoubleBounce(
                  size: 32,
                  color: themeData.colorScheme.primary,
                ),
              );
            },
          ),
          onRefresh: _onRefresh,
          onLoad: _onLoad,
          child: CustomScrollView(slivers: slivers),
        );
      },
    );
  }
}

class _ListHeader extends SliverToBoxAdapter {
  _ListHeader(String title, {double height = 50.0})
      : assert(height > 0),
        super(
            child: SizedBox(
          height: height,
          child: Row(children: [
            Container(
              width: 4,
              height: 14,
              decoration: const BoxDecoration(
                  color: Color(0xFFFFAA22),
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            )
          ]),
        ));
}

class _ProductSliverBuilderDelegate extends SliverChildBuilderDelegate {
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  final List<ProductModel> dataSource;
  final double spacing;
  _ProductSliverBuilderDelegate(this.dataSource, this.spacing)
      : assert(spacing > 0),
        super((context, index) {
          final int itemIndex = index ~/ 2;
          final Widget? widget;
          if (index.isEven) {
            double height = MediaQuery.of(context).size.width - 12.0 * 2;
            var item = dataSource[itemIndex];
            String imgUrl = item.cover;
            var children = <Widget>[
              Image.network(imgUrl),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        item.productName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                      Image.asset(AssetImages.right_arrow)
                    ]),
                  ),
                ),
              )
            ];
            var container = Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              clipBehavior: Clip.antiAlias,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: children,
              ),
            );
            widget = GestureDetector(
              child: container,
              onTap: () {
                context.pushNamed('product_detail');
                // context.push('/product_detail');
                // context.go('/product_detail');
              },
            );
          } else {
            widget = Divider(
              height: spacing,
              color: Colors.transparent,
            );
          }
          return widget;
        }, childCount: _computeActualChildCount(dataSource.length));
}
