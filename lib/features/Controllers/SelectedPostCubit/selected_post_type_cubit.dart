import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'selected_post_type_state.dart';

class SelectedPostTypeCubit extends Cubit<SelectedPostTypeState> {
  SelectedPostTypeCubit() : super(SelectedPostTypeState(selectedValue: 1));

  changeState({
    int? selectedValue,
  }) {
    emit(state.copyWith(selectedValue: selectedValue));
  }
}
