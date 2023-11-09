import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FirstName extends Equatable{
  final Either<Failure,String> firstName;

 const FirstName(this.firstName);
  
  @override
  List<Object?> get props => [firstName];

factory FirstName.validate(String fName)=>FirstName(_validateFirstName(fName));

}


Either<Failure, String> _validateFirstName(String input){
  const firstName=r"^[a-zA-Z]{3}";
  if(RegExp(firstName).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.firstname(failedValue: input));
  }
}
