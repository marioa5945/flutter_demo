import 'package:flutter/material.dart';
import 'package:flutter_demo/MockDatas/MockData.dart';
import 'package:flutter_demo/Models/BuyerShowModel.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgs = <String>[
    "https://static.preclight.com/uploads/2022-12-07/639040aa41197.jpg",
    "https://static.preclight.com/uploads/2022-12-07/6390419bf2995.jpg",
    "https://static.preclight.com/uploads/2023-01-10/63bcdd798edb3.jpg",
    "https://static.preclight.com/uploads/2023-01-03/63b4258a294e8.png",
  ];

  List<BuyerShowModel> list = [];

  @override
  void initState() {
    super.initState();
    buyershowList().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  Widget buildWaterfallFlow(BuildContext context) {
    int crossAxisCount = 2;
    double crossAxisSpacing = 10.0;
    double mainAxisSpacing = 10.0;
    double itemWidth = (MediaQuery.of(context).size.width - 30.0) / 2.0;
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing),
      delegate: SliverChildBuilderDelegate((BuildContext c, int index) {
        final BuyerShowModel model = list[index];
        final double coverH = model.coverHeight / model.coverWidth * itemWidth;
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white),
          alignment: Alignment.center,
          clipBehavior: Clip.antiAlias,
          child: Column(children: [
            SizedBox(
              width: itemWidth,
              height: coverH,
              child: Image.network(model.cover),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                model.title,
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'PingFangSC-Medium'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(model.avatar),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                    child: Text(
                  model.userName,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      const TextStyle(color: Color(0xff666666), fontSize: 12),
                )),
                const SizedBox(
                  width: 10,
                ),
                const Image(
                  image: AssetImage('assets/multiImgs/unlike.png'),
                  width: 14,
                  height: 14,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                const Text(
                  '0.8万',
                  style: TextStyle(color: Color(0xff666666), fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 18.0,
            )
          ]),
        );
      }, childCount: list.length),
    );
  }

  Widget buildTopFixedWidget(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double bannerH = 500.0 / 375.0 * screenW;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          child: Container(
            height: bannerH,
            width: screenW,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Swiper(
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  imgs[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: imgs.length,
              pagination: const SwiperPagination(
                  builder: SwiperPagination.rect,
                  margin: EdgeInsets.symmetric(vertical: 70)),
            ),
          ),
        ),
        Positioned(
            left: 13,
            right: 13,
            bottom: 10,
            child: Container(
              height: 98,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'assets/multiImgs/home_floatingBar_bacground.png'))),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double bannerH = 500.0 / 375.0 * screenW + 49;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(''),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: SizedBox(
            height: bannerH,
            child: buildTopFixedWidget(context),
          )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: buildWaterfallFlow(context),
          ),
        ],
      ),
    );
  }
}
