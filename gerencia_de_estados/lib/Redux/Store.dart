import 'package:flutter/material.dart' hide Action, State;

class Store<Action, State> extends ChangeNotifier {
  State _state;
  final State Function(State state, Action Action) reducer;
  Store({required State initialState, required this.reducer})
      : _state = initialState;

  State get state => _state;

  void dispatcher(action) {
    _state = reducer(state, action);
    notifyListeners();
  }
}
