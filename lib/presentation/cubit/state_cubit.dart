import 'package:flutter_bloc/flutter_bloc.dart';

class StateCubit extends Cubit<String?> {

  StateCubit() : super(null);


  void toggle(String value) => emit(value);


}