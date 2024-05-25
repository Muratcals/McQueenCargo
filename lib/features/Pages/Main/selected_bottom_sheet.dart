import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedBottomSheet extends Cubit<String> {
  SelectedBottomSheet() : super("main");

  void changeValue(String value) {
    emit(value);
  }
}
