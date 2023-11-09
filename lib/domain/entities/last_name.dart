import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LastName extends Equatable{
  final Either<Failure,String> lastName;

 const LastName(this.lastName);
  
  @override
  List<Object?> get props => [lastName];

factory LastName.validate(String fName)=>LastName(_validateLastName(fName));

}


Either<Failure, String> _validateLastName(String input){
  const lastName=r"^[a-zA-Z]{3}";

  if(RegExp(lastName).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.lastname(failedValue: input));
  }
}
