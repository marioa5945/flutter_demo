import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class StackExample extends StatelessWidget {
  const StackExample({super.key});

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double bannerH = 500.0 / 375.0 * screenW;

    return Scaffold(
      appBar: AppBar(title: const Text('Stack Example')),
      body: Container(
        height: 620,
        decoration: const BoxDecoration(color: Colors.red),
        child: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              height: bannerH,
              width: screenW,
              decoration: const BoxDecoration(color: Colors.blue),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    "https://static.preclight.com/uploads/2022-12-28/63abffead582c.jpg",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 5,
                pagination: const SwiperPagination(
                    builder: SwiperPagination.rect,
                    margin: EdgeInsets.symmetric(vertical: 70)),
              ),
            ),
          ),
          Positioned(
              left: 13,
              bottom: 10,
              child: Container(
                width: screenW - 26,
                height: 98,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/multiImgs/home_floatingBar_bacground.png'))),
              )),
        ]),
      ),
    );
  }
}
