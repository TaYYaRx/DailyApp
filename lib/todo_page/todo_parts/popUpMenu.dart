import 'package:daily/pack.dart';

class TodoPopUpMenuButton extends StatelessWidget {
  const TodoPopUpMenuButton({
    Key key,
    @required TextEditingController controller1,
    @required TextEditingController controller2,
    @required this.widget,
  })  : _controller1 = controller1,
        _controller2 = controller2,
        super(key: key);

  final TextEditingController _controller1;
  final TextEditingController _controller2;
  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: Icon(
        FontAwesomeIcons.ellipsisV,
        size: 20,
      ),
      itemBuilder: (BuildContext context) {
        return Constants.choise2.map((str) {
          return PopupMenuItem<String>(
            value: str,
            child: Text(str),
          );
        }).toList();
      },
      onSelected: (value) {
        if (value == Constants.ADD) {
          //ADD
          Future.microtask(() => _controller1.clear());
          Future.microtask(() => _controller2.clear());
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: Colors.grey.shade50,
                  title: Text('Görev Ekle'),
                  content: Container(
                    height: MediaQuery.of(context).size.height*0.25,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _controller1,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  Future.microtask(() => _controller1.clear());
                                },
                              ),
                              hintText: 'Görev Ekle',
                              labelText: 'Görev',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.015,
                        ),
                        TextFormField(
                          controller: _controller2,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  Future.microtask(() => _controller2.clear());
                                },
                              ),
                              hintText: 'İçerik Ekle',
                              labelText: 'İçerik',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Vazgeç"), //VAZGEÇ BUTONU
                      onPressed: () {
                        Future.microtask(() => _controller1.clear());
                        Future.microtask(() => _controller2.clear());
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      color: Colors.purple,
                      child: Text("Ekle"),
                      shape: StadiumBorder(),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                );
              }).then((value) {
            if (value == true) {
              TodoModel model = TodoModel(_controller1.text, 0, widget.catId,
                  content: _controller2.text ?? null);

              BlocProvider.of<TodoBloc>(context)
                  .add(AddTodoItemEvent(model: model));
            }
          });
        } else if (value == Constants.REFRESH) {
          //REFRESH
          BlocProvider.of<TodoBloc>(context)
              .add(RefleshTodosEvent(categoryId: widget.catId));

          BlocProvider.of<TodoBloc>(context).add(FetchAllTodosEvent());
        } else if (value == Constants.DELETE_ALL) {
          //DELETE_ALL
          BlocProvider.of<TodoBloc>(context)
              .add(ClearAllTodosEvent(categoryId: widget.catId));
          BlocProvider.of<TodoBloc>(context).add(FetchAllTodosEvent());
        }
      },
    );
  }
}
