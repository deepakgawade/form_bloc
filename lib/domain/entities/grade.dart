import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/failure.dart';

class Grade extends Equatable{
  final Either<Failure,String> grade;

 const Grade(this.grade);
  
  @override
  List<Object?> get props => [Grade];

factory Grade.validate(String fName)=>Grade(_validateGrade(fName));

}


Either<Failure, String> _validateGrade(String input){
  const grade=r"[0-9A-Z]";

  if(RegExp(grade).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidGrade(failedValue: input));
  }
}