import 'package:assignment/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable{
  final Either<Failure,String> address;

 const Address(this.address);
  
  @override
  List<Object?> get props => [address];

factory Address.validate(String email)=>Address(_validateAddress(email));

}


Either<Failure, String> _validateAddress(String input){
  const address=r"""^[a-zA-z0-9]{3}""";
  if(RegExp(address).hasMatch(input)){
    return right(input);
  }else{
    return left(Failure.invalidAddress(failedValue: input));
  }
}
