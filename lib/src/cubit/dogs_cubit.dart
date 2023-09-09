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
      await Future.delayed(const Duration(milliseconds: 1200));

      final cachorros = await cachorroRepo.getDoguinhos();
      emit(state.copyWith(
          status: DogsStatus.success, message: cachorros.message));
    } catch (e) {
      emit(state.copyWith(status: DogsStatus.failure));
    }
  }

  Future<void> favoritar(String foto) async {
    emit(state.copyWith(status: DogsStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 1200));

      await cachorroRepo.favoritar(foto);
      emit(state.copyWith(
        status: DogsStatus.favoritado,
      ));
    } catch (e) {
      emit(state.copyWith(status: DogsStatus.failure));
    }
  }

  Future<void> getFavoritos() async {
    emit(state.copyWith(status: DogsStatus.loading));

    try {
      await Future.delayed(const Duration(milliseconds: 1200));

      String foto = await cachorroRepo.getFavoritos();

      emit(state.copyWith(status: DogsStatus.success, message: foto));
    } catch (e) {
      emit(state.copyWith(status: DogsStatus.failure));
    }
  }
}
