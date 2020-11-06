import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'percentage_event.dart';
part 'percentage_state.dart';

class PercentageBloc extends Bloc<PercentageEvent, PercentageState> {
  @override
  PercentageState get initialState => PercentageInitial.init();

  @override
  Stream<PercentageState> mapEventToState(
    PercentageEvent event,
  ) async* {
    if(event is ListenPercentageEvent){
      yield ListenerPercentageState(percentage: event.percentage);
    }else{
      print('**********PERCENTAGE BLOC ERROR**********');
    }
  }
}
