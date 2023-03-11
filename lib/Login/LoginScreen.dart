import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/Login/ViewModel/UserViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/Assets/AssetImages.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Image(
            image: AssetImage(AssetImages.login_close),
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: _LoginScreenImp(),
    );
  }
}

class _LoginScreenImp extends StatefulWidget {
  @override
  State<_LoginScreenImp> createState() => _LoginScreenImpState();
}

class _LoginScreenImpState extends State<_LoginScreenImp> {
  Widget _buildHead(BuildContext context) {
    double height = MediaQuery.of(context).size.width * (283.0 / 375.0);
    return SizedBox(
      height: height,
      child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: const [
            Image(
                fit: BoxFit.fill,
                image: AssetImage(AssetImages.login_background)),
            Positioned(
                left: 35,
                bottom: 97,
                child: Text(
                  'APP登录',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ))
          ]),
    );
  }

// IconButton(
//                 icon: const Image(
//                   image: AssetImage(AssetImages.input_clear),
//                 ),
//                 // ignore: avoid_print
//                 onPressed: () => print('hello world'),
//               )
  Widget _phoneTextFiled(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      decoration: const BoxDecoration(
          color: Colors.blue,
          border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A)))),
      child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.yellow,
              hintText: '请输入手机号',
              border: InputBorder.none,
              filled: true,
              suffix: Container(
                width: 20,
                height: 50,
                color: Colors.red,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [_buildHead(context), _phoneTextFiled(context)]),
    );
  }
}
