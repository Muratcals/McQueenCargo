import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Controllers/ProcurementCubit/procurement_state.dart';

class ProcurementCubit extends Cubit<ProcurementState> {
  ProcurementCubit() : super(ProcurementInitial(0, 0));

  changeSelectedProcurement(int selectedProcurement) {
    emit(state.copyWith(
        selectedProcurement: selectedProcurement,
        selectedDelivery: state.selectedDelivery));
  }

  changeSelectedDelivery(int selectedDelivery) {
    emit(state.copyWith(
        selectedProcurement: state.selectedProcurement,
        selectedDelivery: selectedDelivery));
  }
}
