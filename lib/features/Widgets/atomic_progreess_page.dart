import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StackProgressWidget extends StatefulWidget {
  const StackProgressWidget({
    super.key,
    required this.child,
    required this.visibility,
  });
  final Widget child;
  final RxBool visibility;

  @override
  State<StackProgressWidget> createState() => _StackProgressWidgetState();
}

class _StackProgressWidgetState extends State<StackProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AbsorbPointer(
            absorbing: widget.visibility.value,
            child: widget.child,
          ),
          Visibility(
            visible: widget.visibility.value,
            child: Container(
              color: Colors.black45,
              child: Center(
                child: Opacity(
                  opacity: widget.visibility.value ? 0.7 : 0.0,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
