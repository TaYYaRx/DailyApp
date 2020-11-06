part of 'page_bloc.dart';

@immutable
abstract class PageState {}

class PageInitial extends PageState {
  final int pageIndex;

  PageInitial({@required this.pageIndex});

  factory PageInitial.init() {
    return PageInitial(pageIndex: 0);
  }
}

class PageIndexState extends PageState {
  final pageIndex;

  PageIndexState({@required this.pageIndex});
}
