import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => PageInitial.init();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is ChangePageEvent) {
      yield PageIndexState(pageIndex: event.pageIndex);
    }
  }
}
