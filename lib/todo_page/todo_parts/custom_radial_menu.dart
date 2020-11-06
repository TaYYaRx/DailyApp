import 'package:daily/pack.dart';

import 'package:vector_math/vector_math.dart' show radians;

class RadialMenu extends StatefulWidget {
  final TodoModel todoModel;

  const RadialMenu({Key key, @required this.todoModel}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(
      controller: _controller,
      model: widget.todoModel,
    );
  }
}

class RadialAnimation extends StatelessWidget {
  final TodoModel model;
  RadialAnimation({
    Key key,
    this.controller,
    @required this.model,
  })  : scale = Tween<double>(begin: 1, end: 0.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn)),
        translation = Tween<double>(begin: 0.0, end: 45.0).animate(
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
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildButton(
                235,
                icon: FontAwesomeIcons.pen,
                size: 14,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => EditTodoAlertDialog(model: model));
                },
              ),
              _buildButton(
                180,
                size: 20.0,
                icon: (model.getIsDone == 0)
                    ? FontAwesomeIcons.checkCircle
                    : FontAwesomeIcons.timesCircle,
                onPressed: () {
                  var updatedModel = TodoModel.withID(
                      model.getTodoId,
                      model.getTitle,
                      (model.getIsDone == 0) ? 1 : 0,
                      model.getKategoriId);
                  BlocProvider.of<TodoBloc>(context)
                      .add(UpdateTodoItemEvent(model: updatedModel));
                },
              ),
              _buildButton(
                125,
                icon: FontAwesomeIcons.trashAlt,
                size: 14,
                onPressed: () {
                  BlocProvider.of<TodoBloc>(context)
                      .add(DeleteTodoItemEvent(model: model));
                },
              ),
              Transform.scale(
                scale: scale.value - 1,
                child: IconButton(
                    color: Colors.purple,
                    icon: Icon(
                      FontAwesomeIcons.timesCircle,
                    ),
                    onPressed: _close),
              ),
              Transform.scale(
                scale: scale.value,
                child: ClipOval(
                  child: Container(
                    width: 35,
                    height: 35,
                    color: Colors.purple.shade700,
                    child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.cog,
                          size: 16,
                          color: Colors.white,
                        ),
                        onPressed: _open),
                  ),
                ),
              ),
            ],
          );
        });
  }

  _buildButton(
    double angle, {
    @required void Function() onPressed,
    Color color,
    IconData icon,
    double size,
  }) {
    final double rad = radians(angle);

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: ClipOval(
          child: Container(
        alignment: Alignment.center,
        width: 35,
        height: 35,
        color: Colors.purple.shade300,
        child: IconButton(
            icon: Icon(icon, size: size ?? 10, color: color ?? Colors.white),
            onPressed: onPressed),
      )),
    );
  }

  void _open() {
    controller.forward();
  }

  void _close() {
    controller.reverse();
  }
}
