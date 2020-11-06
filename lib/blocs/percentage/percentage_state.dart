part of 'percentage_bloc.dart';

@immutable
abstract class PercentageState {}

class PercentageInitial extends PercentageState {
  final double percentage;
  PercentageInitial({@required this.percentage});
  
  factory PercentageInitial.init() {
    
    return PercentageInitial(percentage: 0.0);
  }
}

class ListenerPercentageState extends PercentageState {
  final double percentage;

  ListenerPercentageState({@required this.percentage});
}
