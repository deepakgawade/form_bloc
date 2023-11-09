import 'package:flutter_bloc/flutter_bloc.dart';
enum Gender { male, female }

class GenderCubit extends Cubit<Gender> {

  GenderCubit() : super(Gender.male);


  void toggle(Gender gen) => emit(gen);


}