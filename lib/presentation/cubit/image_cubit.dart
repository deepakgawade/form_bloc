import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class ImageFileCubit extends Cubit<File?> {

  ImageFileCubit() : super(null);


  void addFile(File? file) => emit(file);


}