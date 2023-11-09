import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ZipCode extends Equatable{
  final Either<Failure,String> zipCode;

 const ZipCode(this .zipCode);
  
  @override
  List<Object?> get props => [ zipCode];

factory ZipCode.validate(String email)=> ZipCode(_validatZipCode(email));

}


Either<Failure, String> _validatZipCode(String input){
  const zipCode=r"""^[0-9]{6}$""";
  if(RegExp (zipCode).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidZipCode(failedValue: input));
  }
}
