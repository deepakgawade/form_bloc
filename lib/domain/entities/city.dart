import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class City extends Equatable{
  final Either<Failure,String> city;

 const City(this .city);
  
  @override
  List<Object?> get props => [ city];

factory City.validate(String email)=> City(_validatCity(email));

}


Either<Failure, String> _validatCity(String input){
  const city=r"""[a-zA-z]""";
  if(RegExp (city).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidCity(failedValue: input));
  }
}
