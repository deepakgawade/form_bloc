import 'package:flutter_bloc/flutter_bloc.dart';

class PassingYearDrpCubit extends Cubit<String?> {

  PassingYearDrpCubit() : super(null);


  void toggle(String value) => emit(value);


}