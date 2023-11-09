import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PhoneNumber extends Equatable{
  final Either<Failure,String> phoneNumber;

 const PhoneNumber(this.phoneNumber);
  
  @override
  List<Object?> get props => [PhoneNumber];

factory PhoneNumber.validate(String fName)=>PhoneNumber(_validatePhoneNumber(fName));

}


Either<Failure, String> _validatePhoneNumber(String input){
  const phoneNumber=r"^[0-9]{10}$";

  if(RegExp(phoneNumber).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidPhone(failedValue: input));
  }
}