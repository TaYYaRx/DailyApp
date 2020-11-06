part of 'page_bloc.dart';

@immutable
abstract class PageEvent {}

class ChangePageEvent extends PageEvent{
  final int pageIndex;
  ChangePageEvent({@required this.pageIndex});
}