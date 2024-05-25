import 'package:flutter/material.dart';

class AtomicFutureBuilder extends StatefulWidget {
  const AtomicFutureBuilder(
      {super.key, required this.future, required this.child});
  final Widget Function(dynamic model) child;
  final Future<dynamic> future;

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
              child: Text(snapshot.error.toString()),
            );
          }
        }
      },
    );
  }
}
