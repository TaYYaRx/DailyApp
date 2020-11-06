import 'package:daily/pack.dart';
part 'main_page/body_part.dart';
part 'main_page/alert_dialog.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) => CategoryBloc(),
        ),
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(),
        ),
        BlocProvider<PageBloc>(
          create: (BuildContext context) => PageBloc(),
        ),
        BlocProvider<PercentageBloc>(
          create: (BuildContext context) => PercentageBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // home: DenemeClass(),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context)
        .add(FetchAllDailysEventForCategory());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        floatingActionButton: FloatingActionButton(
          heroTag: 'btn0',
          backgroundColor: Colors.deepPurple.shade900,
          child: Icon(Icons.add),
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) {
                return AlertDialogBuilder();
              },
            );
          },
        ),
        body: SliverBodyWidget(),
      ),
    );
  }
}
