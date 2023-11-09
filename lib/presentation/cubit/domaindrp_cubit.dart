import 'package:flutter_bloc/flutter_bloc.dart';

class DomianDrpCubit extends Cubit<String?> {

  DomianDrpCubit() : super(null);


  void toggle(String value) => emit(value);


}