import 'package:flutter_bloc/flutter_bloc.dart';

class DesignationDrpCubit extends Cubit<String?> {

  DesignationDrpCubit() : super(null);


  void toggle(String value) => emit(value);


}