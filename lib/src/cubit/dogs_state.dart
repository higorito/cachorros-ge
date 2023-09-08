part of 'dogs_cubit.dart';

enum DogsStatus { initial, loading, success, failure }

class DogsState extends Equatable {
  const DogsState({
    this.message,
    this.status = DogsStatus.initial,
  });

  final String? message;
  final DogsStatus status;

  DogsState copyWith({
    String? message,
    DogsStatus? status,
  }) {
    return DogsState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [message, status];
}
