import '../pack.dart';

class PercentageModel {
  int percentage;
  PercentageModel({@required this.percentage});
  
  factory PercentageModel.init(){
    return PercentageModel(percentage: 0);
  }

  int get getPercentage => this.percentage;
}
