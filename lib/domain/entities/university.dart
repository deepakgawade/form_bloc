import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/failure.dart';

class University extends Equatable{
  final Either<Failure,String> university;

 const University(this.university);
  
  @override
  List<Object?> get props => [University];

factory University.validate(String fName)=>University(_validateUniversity(fName));

}


Either<Failure, String> _validateUniversity(String input){
  const university=r"[a-zA-Z]";

  if(RegExp(university).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidUniversity(failedValue: input));
  }
}