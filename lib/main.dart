import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/GenerateRoute/generate_route.dart';
import 'package:mc_queen_cargo/features/Constants/GetCourierCubit/post_courier_cubit.dart';
import 'package:mc_queen_cargo/main_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCpaVwdQqugEk-f0BVApOvIR8WdRag1CeI",
              appId: "1:639272645378:android:0acf4236e5d6c14c97c81b",
              messagingSenderId: "639272645378",
              projectId: "mcqueencargo-858dd"))
      : Firebase.initializeApp();
  runApp(
    BlocProvider(
        create: (context) => GetCourierPostCubit(), child: const MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with MainAppMixin {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 420),
      child: Obx(
          () => visibility.value ? _DefaultWidget() : _NotConnectionWidget()),
    );
  }
}

class _DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      getPages: GenerateRoute.getPages(),
      supportedLocales: const [Locale('tr'), Locale('en')],
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.orange.shade400),
          ),
        ),
      ),
    );
  }
}

class _NotConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: const AppbarFlexibleSpace(),
          title: GeneralTextWidget(
              title: "Bağlantı bulunamadı",
              fontsize: 14.sp,
              color: Colors.white),
          centerTitle: true,
          toolbarHeight: 30.h,
        ),
        body: Center(
            child: GeneralTextWidget(
                title: "İnternet bağlantınızı kontrol ediniz",
                fontsize: 14.sp)),
      ),
    );
  }
}
