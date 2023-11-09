import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Password extends Equatable{
  final Either<Failure,String> password;

 const Password(this.password);
  
  @override
  List<Object?> get props => [Password];

factory Password.validate(String email)=>Password(_validatePassword(email));

}


Either<Failure, String> _validatePassword(String input){
  const password=r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* )";
  if(RegExp(password).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.shortPassword(failedValue: input));
  }
}
