import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class YearOfExperience extends Equatable{
  final Either<Failure,String> yearOfExperinece;

 const YearOfExperience(this.yearOfExperinece);
  
  @override
  List<Object?> get props => [yearOfExperinece];

factory YearOfExperience.validate(String fName)=>YearOfExperience(_validateyearOfexperinece(fName));

}


Either<Failure, String> _validateyearOfexperinece(String input){
  const yearOfExperinece=r"^[0-9]$";

  if(RegExp(yearOfExperinece).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidYEO(failedValue: input));
  }
}