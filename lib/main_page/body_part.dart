part of 'package:daily/main.dart';

class SliverBodyWidget extends StatefulWidget {
  const SliverBodyWidget({
    Key key,
  }) : super(key: key);

  @override
  _SliverBodyWidgetState createState() => _SliverBodyWidgetState();
}

class _SliverBodyWidgetState extends State<SliverBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        //TOP Resim
        SliverAppBar(
          title: Text('ToDo'),
          backgroundColor: Color(0xFF3d485c),
          expandedHeight: MediaQuery.of(context).size.height * 0.322108,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 2000),
                  children: [
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(Constants().pickImage()),
                        ),
                      ),
                    )
                  ],
                  childAnimationBuilder: (Widget widget) =>
                      FadeInAnimation(child: widget)),
            ),
          ),
        ),
        //CENTER StatusBar
        MainStatusBar(),
        //BOTTOM GridListView
        BottomSection()
      ],
    );
  }
}
