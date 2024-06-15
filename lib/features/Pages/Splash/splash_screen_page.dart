import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Authorazation/token.dart';
import 'package:mc_queen_cargo/features/Pages/Splash/splash_screen_mixin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenMixin {
  @override
  void initState() {
      super.initState();
      getUser().then((value) {
      saveToken(
          accessToken: value.accessToken!, refreshToken: value.refreshToken!);
      AuthenticationToken.token = value.accessToken!;
      loginModelProcess(value.accessToken!);
    }).onError((error, stackTrace) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF001220),
        body: _SplashScreenBody(),
      ),
    );
  }
}

class _SplashScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "images/app_icon.png",
        width: 250.w,
        height: 250.h,
      ),
    );
  }
}
