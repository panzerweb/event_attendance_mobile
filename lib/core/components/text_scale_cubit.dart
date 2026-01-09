import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextScaleCubit extends Cubit<double> {
  TextScaleCubit() : super(1.0) {
    _loadTextScale();
  }

  Future<void> _loadTextScale() async {
    final prefs = await SharedPreferences.getInstance();
    final scale = prefs.getDouble('textScale') ?? 1.0;
    emit(scale);
  }

  Future<void> setTextScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textScale', scale);
    emit(scale);
  }
}
