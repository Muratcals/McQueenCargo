import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/features/Service/response_error.dart';
import 'package:mc_queen_cargo/features/View/Splash/splash_screen_mixin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenMixin {
  @override
  void initState() {
    
    ErrorResponse.stream.listen((event) {
      ErrorResponse.responseErrorDialog(context, event);
    });
    getUser();
    super.initState();
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
