import 'package:bloc/bloc.dart';
import 'package:fluttertoast/Fluttertoast.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    if (state < 10) {
      emit(state + 1);
    } else {
      _showLimitToast();
    }
  }

  void decrement() {
    if (state > -10) {
      emit(state - 1);
    } else {
      _showLimitToast();
    }
  }

  void reset() => emit(0);

  void _showLimitToast() {
    Fluttertoast.showToast(
      msg: "Límite alcanzado",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}