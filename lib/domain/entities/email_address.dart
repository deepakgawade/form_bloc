import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class EmailAddress extends Equatable{
  final Either<Failure,String> emailAddress;

 const EmailAddress(this.emailAddress);
  
  @override
  List<Object?> get props => [EmailAddress];

factory EmailAddress.validate(String email)=>EmailAddress(_validateEmailAddress(email));

}


Either<Failure, String> _validateEmailAddress(String input){
  const emailAddress=r"""^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$""";
  if(RegExp(emailAddress).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidEmail(failedValue: input));
  }
}
