part of 'example_bloc.dart';

@immutable
abstract class ExampleState {}

class ExampleInitial extends ExampleState {}


class IncrementState extends ExampleState {
  final int count;

  IncrementState({required this.count});
}