part of 'selected_post_type_cubit.dart';

class SelectedPostTypeState extends Equatable {
  int selectedValue;

  SelectedPostTypeState({required this.selectedValue});

  @override
  List<Object> get props => [selectedValue];

  SelectedPostTypeState copyWith({
    int? selectedValue,
  }) {
    return SelectedPostTypeState(
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }
}

final class SelectedValueInitial extends SelectedPostTypeState {
  SelectedValueInitial({required super.selectedValue});
}
