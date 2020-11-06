part of 'percentage_bloc.dart';

@immutable
abstract class PercentageEvent {}

class ListenPercentageEvent extends PercentageEvent {
  final double percentage;

  ListenPercentageEvent({@required this.percentage});
}
