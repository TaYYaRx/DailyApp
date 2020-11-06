import 'package:daily/pack.dart';

class MainStatusBar extends StatelessWidget {
  const MainStatusBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ClipPath(
        clipper: WaveClipperOne(),
        child: Container(
          decoration: BoxDecoration(gradient: Constants().customGradient()),
          height: MediaQuery.of(context).size.height*0.175,
          //color: Color(0xFF9D4389),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (BuildContext context, TodoState state) {
              if (state is TodoLoadedState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          state.todos.length.toString(),
                          style: TextStyle(
                              fontSize: 28, color: Colors.white70),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Oluşturulan\nGörevler',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          state.todoCompletedTotal().length.toString(),
                          style: TextStyle(
                              fontSize: 28, color: Colors.white70),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Biten\nGörevler',
                          style: TextStyle(
                              fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    )
                  ],
                );
              } else {
                BlocProvider.of<TodoBloc>(context)
                    .add(FetchAllTodosEvent());
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}