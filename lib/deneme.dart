import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DenemeClass extends StatefulWidget {
  @override
  _DenemeClassState createState() => _DenemeClassState();
}

class _DenemeClassState extends State<DenemeClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Deneme'),
        ),
        body: Center(
            child: Container(
          color: Colors.pink,
          width: 150,
          height: 150,
          child: RadialMenu(),
        )));
  }
}

class RadialMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: _controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({
    Key key,
    this.controller,
  })  : scale = Tween<double>(begin: 1, end: 0.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        translation = Tween<double>(begin: 0.0, end: 75.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.elasticOut)),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {   
          return Container(
            color: Colors.red.shade200,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildButton(60,
                    color: Colors.pink, icon: FontAwesomeIcons.fire),
                Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: _close,
                    child: Icon(FontAwesomeIcons.timesCircle),
                  ),
                ),
                Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: _open,
                    child: Icon(FontAwesomeIcons.solidDotCircle),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    //final double rad = radians(angle);

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(angle),
          (translation.value) * sin(angle),
        ),
      child: FloatingActionButton(
        child: Icon(icon),
        backgroundColor: color,
        onPressed: _close,
      ),
    );
  }

  void _open() {
    controller.forward();
  }

  void _close() {
    controller.reverse();
  }
}
