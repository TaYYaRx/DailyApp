
import 'package:daily/pack.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key key,
    @required int position,
    @required this.widget,
  })  : _position = position,
        super(key: key);

  final int _position;
  final TodoPage widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          List<TodoModel> list;

          if (state is TodoLoadedState) {
            switch (_position) {
              case 0:
                list = state.todoUncompleted(widget.catId);
                break;
              case 1:
                list = state.todoCompleted(widget.catId);
                break;
              case 2:
                list = state.entireList(widget.catId);
                break;
              default:
                list = [];
            }
          }
          return AnimationLimiter(
              child: ListView.builder(
            padding: EdgeInsets.all(4),
            itemBuilder: (BuildContext context, int index) {
              if (_position != 2) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                        verticalOffset: 150.0,
                        child: FadeInAnimation(
                            child: Dismissible(
                          key: UniqueKey(),
                          child: _listElement(list, index, context),
                          onDismissed: (d) {
                            if (_position != 2) {
                              _updateItem(list, index, context);
                            }
                          },
                        ))));
              } else {
                return _listElement(list, index, context);
              }
            },
            itemCount: list.length,
          ));
        },
      ),
    );
  }

  Container _listElement(
      List<TodoModel> list, int index, BuildContext context) {
        
    return Container(
      //color: Colors.blue,
      height: MediaQuery.of(context).size.height*0.176,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          child: Center(
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: (MediaQuery.of(context).size.width) * 0.1,
                  height: MediaQuery.of(context).size.height*0.146,
                  child: Icon(
                    FontAwesomeIcons.checkCircle,
                    size: 30,
                    color: (list[index].getIsDone == 1)
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                    //  color: Colors.green,
                    height: MediaQuery.of(context).size.height*0.146,
                    width: (MediaQuery.of(context).size.width) * 0.55,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${list[index].getTitle}',
                            style: TextStyle(
                                fontSize: 22,
                                decoration: (list[index].getIsDone == 1)
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: (list[index].getIsDone == 1)? Colors.grey:null),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              '${list[index].getContent ?? ''}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  width: (MediaQuery.of(context).size.width) * 0.24,
                  height: MediaQuery.of(context).size.height*0.146,
                  // color: Colors.blue,
                  child: RadialMenu(
                    todoModel: list[index],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  void _updateItem(List<TodoModel> list, int index, BuildContext context) {
    var _newModel = TodoModel.withID(
      list[index].getTodoId,
      list[index].getTitle,
      list[index].getIsDone == 0 ? 1 : 0,
      list[index].getKategoriId,
      content: list[index].getContent,
    );
    BlocProvider.of<TodoBloc>(context)
        .add(UpdateTodoItemEvent(model: _newModel));
  }
}
