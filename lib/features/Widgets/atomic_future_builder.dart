// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_queen_cargo/main_mixin.dart';

class AtomicFutureBuilder extends StatefulWidget {
  const AtomicFutureBuilder({
    super.key,
    required this.child,
    required this.future,
    required this.onError,
  });
  final Widget Function(dynamic model) child;
  final Future<dynamic> future;
  final VoidCallback onError;

  @override
  State<AtomicFutureBuilder> createState() => _AtomicFutureBuilderState();
}

class _AtomicFutureBuilderState extends State<AtomicFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasData) {
          return widget.child(snapshot.data);
        } else {
          if (snapshot.error == "Not Found") {
            return widget.child(snapshot.error);
          } else {
            return Center(
              child: Column(
                children: [
                  GeneralTextWidget(
                    title: "Beklenmedik bir hata oluştu. Lütfen tekrar ediniz",
                    fontsize: 13.sp,
                  ),
                  ElevatedButton(
                      onPressed: widget.onError,
                      child: GeneralTextWidget(
                        title: "Tekrar Dene",
                        fontsize: 12.sp,
                        color: Colors.white,
                      ))
                ],
              ),
            );
          }
        }
      },
    );
  }
}
