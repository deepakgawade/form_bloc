import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Locality extends Equatable{
  final Either<Failure,String> locality;

 const Locality(this .locality);
  
  @override
  List<Object?> get props => [ locality];

factory Locality.validate(String email)=> Locality(_validatLocality(email));

}


Either<Failure, String> _validatLocality(String input){
  const locality=r"""^[a-zA-z]{3}""";
  if(RegExp (locality).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidLocality(failedValue: input));
  }
}
