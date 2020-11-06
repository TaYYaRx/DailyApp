import 'package:daily/pack.dart';
import 'package:daily/todo_page/todopage_main.dart';

import '../pack.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<CategoryBloc>(context),
      builder: (context, state) {
        if (state is CategoryLoadedState) {
          return CategoryItemBuild(list: state.categories);
        } else {
          return SliverToBoxAdapter(
            child: Container(
              child: Text('ERROR-1'),
            ),
          );
        }
      },
    );
  }
}

class CategoryItemBuild extends StatefulWidget {
  const CategoryItemBuild({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<CategoryModel> list;

  @override
  _CategoryItemBuildState createState() => _CategoryItemBuildState();
}

class _CategoryItemBuildState extends State<CategoryItemBuild> {
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width*0.54,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state is TodoInitialState) {
              return Container();
            } else if (state is TodoLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TodoLoadedState) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.only(top: 12),
                      decoration:
                          BoxDecoration(gradient: Constants().customGradient()),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              //'id' , 'kategori'
                              //Settings-->
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Expanded(
                                      child: Text(
                                    widget.list[index].categoryName
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                    textAlign: TextAlign.center,
                                  )),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.white70,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onSelected: (value) {
                                        if (value == Constants.EDIT) {
                                          buildShowDialog(context, index);
                                        } else if (value == Constants.DELETE) {
                                          BlocProvider.of<CategoryBloc>(context)
                                              .add(DeleteCategoryEvent(
                                                  model: widget.list[index]));
                                          BlocProvider.of<TodoBloc>(context)
                                              .add(FetchAllTodosEvent());
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return Constants.choise.map((str) {
                                          return PopupMenuItem<String>(
                                            value: str,
                                            child: Text(str),
                                          );
                                        }).toList();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 80),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  BlocBuilder<TodoBloc, TodoState>(
                                    builder: (BuildContext context, state) {
                                      double yuzde = 0;
                                      if (state is TodoLoadedState) {
                                        var tamam = state
                                            .todoCompleted(
                                                widget.list[index].id)
                                            .length;
                                        var toplam = state
                                                .todoUncompleted(
                                                    widget.list[index].id)
                                                .length +
                                            tamam;
                                        yuzde = tamam / toplam;
                                      }

                                      return LinearPercentIndicator(
                                        linearGradient: LinearGradient(colors: [
                                          Colors.deepPurple.shade900,
                                          Colors.deepPurple.shade400
                                        ]),
                                        center: Text(
                                          '%${(yuzde.isNaN) ? 0 : (yuzde * 100).toStringAsFixed(0)}',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        width: 160.0,
                                        animation: true,
                                        animationDuration: 500,
                                        lineHeight: 14.0,
                                        percent: (yuzde.isNaN) ? 0 : yuzde,
                                        backgroundColor: Colors.white,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  //TODO --- TIKLA SAYFAYA GİT
                  //index => kategori indexleri
                  int ilgiliKategoriID = widget.list[index].id;

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => TodoPage(
                            catId: ilgiliKategoriID,
                            label: widget.list[index].categoryName,
                          )));
                },
              );
            } else {
              print('state is not Loaded');
              return Container();
            }
          },
        );
      }, childCount: widget.list.length),
    );
  }

  Future buildShowDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
            backgroundColor: Colors.grey[50],
            title: Text('Kategori Düzenle'),
            content: Container(
                height: 60,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                Future.microtask(() => _textController.clear());
                              }),
                          hintText: 'Düzenle',
                          labelText: 'Kategori',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
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
                child: Text("Düzenle"),
                shape: StadiumBorder(),
                onPressed: () {
                  CategoryModel model = CategoryModel.withID(
                      id: widget.list[index].getId,
                      categoryName: _textController.text);
                  BlocProvider.of<CategoryBloc>(context)
                      .add(UpdateCategoryEvent(model: model));

                  Navigator.of(context).pop();
                },
              )
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)));
      },
    );
  }
}
