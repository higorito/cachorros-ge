import 'package:auau_gerador/src/data/model/cachorros_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/repository/cachorro_repo.dart';

part 'dogs_state.dart';

class DogsCubit extends Cubit<DogsState> {
  final CachorrosModel cachorros;
  final cachorroRepo = CachorroRepo();

  DogsCubit({required this.cachorros}) : super(const DogsState());

  Future<void> getDog() async {
    emit(state.copyWith(status: DogsStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final cachorros = await cachorroRepo.getDoguinhos();
      emit(state.copyWith(
          status: DogsStatus.success, message: cachorros.message));
    } catch (e) {
      emit(state.copyWith(status: DogsStatus.failure));
    }
  }
}
