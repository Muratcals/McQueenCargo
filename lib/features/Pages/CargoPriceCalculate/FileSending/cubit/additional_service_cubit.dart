import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'additional_service_state.dart';

class AdditionalServiceCubit extends Cubit<AdditionalServiceState> {
  AdditionalServiceCubit() : super(AdditionalServiceInitial(0, 0));

  changed(int i) {
    state.selectedDelivery = i;
    emit(state);
  }
  changes(int i) {
    state.selectedProcurement = i;
    emit(state);
  }
}
