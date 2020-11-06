import 'package:daily/pack.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TodoPage extends StatefulWidget {
  final int catId;
  final String label;

  const TodoPage({Key key, @required this.catId, @required this.label})
      : super(key: key);
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var _position = 0;
  TextEditingController _controller1;
  TextEditingController _controller2;
  final String image = Constants().pickImage();
  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey.shade200,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            actions: <Widget>[
              TodoPopUpMenuButton(
                  controller1: _controller1,
                  controller2: _controller2,
                  widget: widget)
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: AnimationConfiguration.synchronized(
              child: Text(widget.label),
              duration: Duration(seconds: 2),
            )),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: FontAwesomeIcons.tasks, title: "Liste"),
            TabData(iconData: FontAwesomeIcons.checkDouble, title: "Bitmiş"),
            TabData(iconData: FontAwesomeIcons.list, title: "Hepsi")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _position = position;
            });
          },
        ),
        //BODY--<
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: AnimationConfiguration.toStaggeredList(
                      duration: Duration(milliseconds: 2000),
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height*0.3415,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(image),
                            ),
                          ),
                        )
                      ],
                      childAnimationBuilder: (Widget widget) =>
                          FadeInAnimation(child: widget)),
                ),
                Positioned(
                  child: Text('${Constants().getCurrentDate()}',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  bottom: 15,
                  left: 15,
                ),
                StatusBar(widget: widget)
              ],
            ),
            ListItems(position: _position, widget: widget)
          ],
        ));
  }
}
