import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  ExampleBloc() : super(ExampleInitial());

  int count = 0;

  @override
  Stream<ExampleState> mapEventToState(
    ExampleEvent event,
  ) async* {
    if(event is IncrementEvent) {


      ++count;

      yield IncrementState(count: count);
    }
  }

  void clear() {
    count = 0;
  }

}
