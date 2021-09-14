import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Login, Logout }

bool loginReducer(bool state, dynamic action) {
  if (action == Actions.Login) {
    state = true;
  } else {
    state = false;
  }

  return state;
}

void main() {
  final store = Store<bool>(loginReducer, initialState: false);

  runApp(FlutterReduxApp(
    title: 'Login Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<bool> store;
  final String title;

  FlutterReduxApp({
    Key? key,
    required this.store,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<bool>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<bool, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, loged) {
                    return Text(
                      'User loged: $loged',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: StoreConnector<bool, VoidCallback>(
            converter: (store) {
              if (store.state == false) {
                return () => store.dispatch(Actions.Login);
              } else {
                return () => store.dispatch(Actions.Logout);
              }
            },
            builder: (context, callback) {
              return store.state
                  ? FloatingActionButton(
                      onPressed: callback,
                      tooltip: 'Login',
                      child: Icon(Icons.login),
                    )
                  : FloatingActionButton(
                      onPressed: callback,
                      tooltip: 'Logout',
                      child: Icon(Icons.logout));
            },
          ),
        ),
      ),
    );
  }
}
