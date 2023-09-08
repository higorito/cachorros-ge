import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dogs_state.dart';

class DogsCubit extends Cubit<DogsState> {
  DogsCubit() : super(DogsInitial());
}
