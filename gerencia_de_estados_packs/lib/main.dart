import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'middleware.dart';
import 'reducers.dart';
import 'state.dart';
import 'to_do_list_page.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createStoreMiddleware(),
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
        store: this.store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: ToDoListPage(),
        ),
      );
}
