import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_queen_cargo/features/Model/neighbourhood_model.dart';

class NeighbourhoodController extends Cubit<List<NeighbourhoodModel>> {
  NeighbourhoodController():super([]);

  void changeList(List<NeighbourhoodModel> model) {
    emit(model);
  }
}
