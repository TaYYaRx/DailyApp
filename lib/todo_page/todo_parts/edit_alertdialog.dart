import 'package:daily/pack.dart';

class EditTodoAlertDialog extends StatefulWidget {
  final TodoModel model;
  const EditTodoAlertDialog({Key key, @required this.model}) : super(key: key);

  @override
  _EditTodoAlertDialogState createState() => _EditTodoAlertDialogState();
}

class _EditTodoAlertDialogState extends State<EditTodoAlertDialog> {
  TextEditingController _textControllerTitleEdit;
  TextEditingController _textControllerContentEdit;

  @override
  void initState() {
    super.initState();
    _textControllerTitleEdit = TextEditingController();
    _textControllerContentEdit = TextEditingController();

    _textControllerTitleEdit.text = widget.model.getTitle;
    _textControllerContentEdit.text = widget.model.getContent;
  }

  @override
  void dispose() {
    _textControllerTitleEdit.dispose();
    _textControllerContentEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        width: MediaQuery.of(context).size.width*0.70,
        height: MediaQuery.of(context).size.height*0.35,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height*0.11,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    FontAwesomeIcons.edit,
                    size: 50,
                    color: Colors.purple,
                  )),
            ),
            Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.briefcase,
                  size: 28,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.07,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textControllerTitleEdit,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              Future.microtask(
                                  () => _textControllerTitleEdit.clear());
                            }),
                        hintText: 'Görev giriniz',
                        labelText: 'Görev',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            ),
            Divider(
              height: MediaQuery.of(context).size.height*0.04,
            ),
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.solidStickyNote, size: 28),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.07,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _textControllerContentEdit,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              Future.microtask(
                                  () => _textControllerContentEdit.clear());
                            }),
                        hintText: 'Konu',
                        labelText: 'İçerik',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.purple,
          child: Text("Düzenle"),
          shape: StadiumBorder(),
          onPressed: () {
            TodoModel editedModel = TodoModel.withID(
                widget.model.getTodoId,
                _textControllerTitleEdit.text,
                widget.model.getIsDone,
                widget.model.getKategoriId,
                content: _textControllerContentEdit.text);

            BlocProvider.of<TodoBloc>(context)
                .add(UpdateTodoItemEvent(model: editedModel));

                Navigator.of(context).pop();

       
          },
        ),
        FlatButton(
          child: Text("Vazgeç"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
