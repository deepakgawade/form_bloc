import 'package:flutter_bloc/flutter_bloc.dart';

class EducationDrpCubit extends Cubit<String?> {

  EducationDrpCubit() : super(null);


  void toggle(String value) => emit(value);


}