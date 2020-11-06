import 'package:daily/pack.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (BuildContext context, state) {
          int gorev;
          int tamam;
          double yuzde;
          if (state is TodoLoadedState) {
            gorev = state.entireList(widget.catId).length;
            tamam = state.todoCompleted(widget.catId).length;
            yuzde = state.percentage(widget.catId);
          }

          return Container(
            color: Colors.black.withOpacity(0.3),
            width: MediaQuery.of(context).size.width * 0.304136,
            height: MediaQuery.of(context).size.height * 0.3415,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 1375),
                    childAnimationBuilder: (widget) =>
                        FadeInAnimation(child: widget),
                    children: [
                      Row(
                        //ilk satır
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Görev',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Text(
                                gorev.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Text(
                                  'Biten',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              Text(tamam.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularPercentIndicator(
                            animation: true,
                            animateFromLastPercent: true,
                            radius: MediaQuery.of(context).size.width*0.07,
                            backgroundColor: Colors.white,
                            lineWidth: 3,
                            linearGradient: LinearGradient(colors: [
                              Colors.deepPurpleAccent.shade700,
                              Colors.purpleAccent.shade100
                            ]),
                            percent: (yuzde.isNaN) ? 0 : yuzde,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.048661,
                          ),
                          Text(
                            '${(yuzde.isNaN) ? 0 : (yuzde * 100).toInt()}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.043923,
                      )
                    ])),
          );
        },
      ),
    );
  }
}
