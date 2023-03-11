import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/Config/Routes.dart';
import 'package:flutter_demo/Customization/CustomizationScreen.dart';
import 'package:flutter_demo/Customization/ProductDetailScreen.dart';
import 'package:flutter_demo/Home/home_screen.dart';
import 'package:flutter_demo/Login/LoginScreen.dart';
import 'package:flutter_demo/Login/ViewModel/UserViewModel.dart';
import 'package:flutter_demo/Mine/mine_screen.dart';
import 'package:flutter_demo/Network/http/ServiceManager.dart';
import 'package:flutter_demo/Network/service/XmhService.dart';
import 'package:flutter_demo/TabPageContainer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppRoot());
  ServiceManager().registService(XmhService());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class AppRoot extends StatelessWidget {
  AppRoot({super.key});

  final UserViewModel _userViewModel = UserViewModel();

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.root,
    refreshListenable: _userViewModel,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.root,
        builder: (context, state) => const _AppImp(),
        routes: <RouteBase>[
          GoRoute(
            name: 'product_detail',
            path: Routes.productDetail,
            builder: (context, state) => const ProductDetailScreen(),
          ),
          GoRoute(
            path: Routes.login,
            pageBuilder: (context, state) {
              return const MaterialPage(
                  fullscreenDialog: true, child: LoginScreen());
            },
          )
        ],
        redirect: (context, state) {
          // UserViewModel userVM = Provider.of<UserViewModel>(context);
          UserViewModel viewModel = context.read<UserViewModel>();
          final bool loggedIn = viewModel.loggedIn;
          final bool loggingIn = state.location == '/login';

          if (state.location == '/product_detail' && !loggedIn) {
            return '/login';
          }

          if (loggingIn && loggedIn) {
            return '/';
          }
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _userViewModel,
          )
        ],
        child: MaterialApp.router(
          theme: ThemeData(
              brightness: Brightness.light,
              colorSchemeSeed: const Color(0xFFFFAA22),
              useMaterial3: true),
          routerConfig: _router,
        ));
  }
}

class _AppImp extends StatefulWidget {
  const _AppImp({super.key});

  @override
  State<_AppImp> createState() => _AppImpState();
}

class _AppImpState extends State<_AppImp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabPageContainer(
          currentIndex: _currentIndex,
          children: const [HomeScreen(), CustomizationScreen(), MineScreen()]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/multiImgs/home.png'),
                size: 32,
              ),
              label: '首页'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/multiImgs/custom.png'),
                size: 32,
              ),
              label: '定制'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/multiImgs/mine.png'),
                size: 32,
              ),
              label: '我的')
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
