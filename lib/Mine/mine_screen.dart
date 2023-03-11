import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class MineScreen extends StatefulWidget {
  const MineScreen({super.key});

  @override
  State<MineScreen> createState() => _MineScreen();
}

@JsonSerializable()
class Nav {
  final String url;
  final String title;
  final String icon;

  Nav(this.url, this.title, this.icon);
}

class _MineScreen extends State<MineScreen> {
  List<Nav> navs = [
    Nav('/', '收货地址',
        'https://static.preclight.com/static/img/uni-magic-box/mine/i03.png'),
    Nav('/', '联系客服',
        'https://static.preclight.com/static/img/uni-magic-box/mine/i04.png'),
    Nav('/', '我的模型',
        'https://static.preclight.com/static/img/uni-magic-box/mine/i01.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          color: const Color.fromRGBO(248, 248, 248, 1),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            // alignment: Alignment.center,
            // padding: const EdgeInsets.only(top: 10.0),
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Image.network(
                  'https://static.preclight.com/static/img/uni-magic-box/mine/bg01.png',
                  fit: BoxFit.fill,
                ),
              ),
              const Positioned(
                  top: 54,
                  right: 17,
                  child: Image(
                    image: AssetImage('assets/mine/i01.png'),
                    width: 26,
                    height: 26,
                  )),
              Container(
                padding: const EdgeInsets.only(top: 130, left: 19),
                child: Row(children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                          'https://static.preclight.com/uploads/2022-12-28/63abf8cf52957.jpg'),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                          left: 10), // apply padding to all four sides
                      child: Text(
                        '小模盒用户',
                        style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200, left: 14, right: 14),
                padding: const EdgeInsets.fromLTRB(6, 20, 6, 20),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < navs.length; i++)
                      Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xF4F4F4FF)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Image.network(
                                    navs[i].icon,
                                    width: 22,
                                    height: 22,
                                  ),
                                ),
                                Text(
                                  navs[i].title,
                                  style: const TextStyle(
                                      color: Color(0xFF1A1A1A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const Image(
                              image: AssetImage('assets/mine/i05.png'),
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
