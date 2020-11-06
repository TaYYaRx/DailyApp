part of 'package:daily/main.dart';
class AlertDialogBuilder extends StatefulWidget {
  AlertDialogBuilder({
    Key key,
  }) : super(key: key);

  @override
  _AlertDialogBuilderState createState() => _AlertDialogBuilderState();
}

class _AlertDialogBuilderState extends State<AlertDialogBuilder> {
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.grey[50],
        title: Text("Kategori Ekle"),
        content: Container(
            height: MediaQuery.of(context).size.height*0.1,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            Future.microtask(
                                () => _textController.clear());
                          }),
                      hintText: 'Kategori ekle',
                      labelText: 'Kategori',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            )),
        actions: <Widget>[
          FlatButton(
            child: Text("Vazgeç"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            color: Colors.purple,
            child: Text("Ekle"),
            shape: StadiumBorder(),
            onPressed: () {
              BlocProvider.of<CategoryBloc>(context).add(AddCategoryEvent(
                  model: CategoryModel(categoryName: _textController.text)));
              Navigator.of(context).pop();
            },
          )
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
  }
}
