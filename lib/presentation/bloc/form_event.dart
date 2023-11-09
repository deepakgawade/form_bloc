part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}


class RegisterEvent extends FormEvent{

  final String emailAddress;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String confirmpassword;

 const RegisterEvent( {required this.confirmpassword,required this.phoneNumber,required this.emailAddress, required this.firstName, required this.lastName, required this.password});

}

class AddInfoEvent extends FormEvent{

  final String education;
  final String yearOfPassing;
  final String yearOfExperience;
  final String grade;
  final String university;
  final String designation;
  final String domain;


 const AddInfoEvent( {required this.designation, required this.domain, required this.yearOfExperience,required this.grade, required this.university,required this.education,required this.yearOfPassing, });
  
}

class AddAddressEvent extends FormEvent{

  final String address;
  final String landmark;
  final String city;
  final String state;
  final String zipcode;

 const AddAddressEvent({required this.address, required this.landmark, required this.city, required this.state, required this.zipcode});

  
  
}
class ResetEvent extends FormEvent{
  
}
