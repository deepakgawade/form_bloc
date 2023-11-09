import 'package:assignment/domain/entities/address.dart';
import 'package:assignment/domain/entities/city.dart';
import 'package:assignment/domain/entities/email_address.dart';
import 'package:assignment/domain/entities/first_name.dart';
import 'package:assignment/domain/entities/grade.dart';
import 'package:assignment/domain/entities/last_name.dart';
import 'package:assignment/domain/entities/locality.dart';
import 'package:assignment/domain/entities/password.dart';
import 'package:assignment/domain/entities/phone_number.dart';
import 'package:assignment/domain/entities/university.dart';
import 'package:assignment/domain/entities/year_of_experience.dart';
import 'package:assignment/domain/entities/zipcode.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, RegFormState> {
  FormBloc() : super(InitialState()) {
    on<RegisterEvent>(validateRegistartionForm);
    on<ResetEvent>(reset);
    on<AddInfoEvent>(validateYourInfoForm);
    on<AddAddressEvent>(validateAddressForm);
  }
  void validateRegistartionForm(
      RegisterEvent event, Emitter<RegFormState> emit) async {
    final isEmailValid =
        EmailAddress.validate(event.emailAddress).emailAddress.isRight();
    final isPasswordValid =
        Password.validate(event.password).password.isRight();
    final isfirstNameValid =
        FirstName.validate(event.firstName).firstName.isRight();
    final isLastNameValid =
        LastName.validate(event.lastName).lastName.isRight();
    final isPhoneNumberValid =
        PhoneNumber.validate(event.phoneNumber).phoneNumber.isRight();

    if (!isLastNameValid) {
      emit(const RegisterValidFailedState("Please enter Valid Last Name"));
    } 
    else if (!isPhoneNumberValid) {
      emit(const RegisterValidFailedState("Please enter 10 digit mobile number"));
    }else if (!isEmailValid) {
      emit(const RegisterValidFailedState("Please enter Valid email"));
    } else if (!isPasswordValid) {
      emit(const RegisterValidFailedState(
          "Password should contain at least 1 number, 1 special character"));
    }
    else if (event.password.compareTo(event.confirmpassword)!=0) {
      emit(const RegisterValidFailedState(
          "Password Does not match"));
    } else if (!isfirstNameValid) {
      emit(const RegisterValidFailedState("Please Enter valid first Name"));
    }else{
      emit(RegisterValidState());
    }

  }

   void validateYourInfoForm(
     AddInfoEvent  event, Emitter<RegFormState> emit) async {
  final isGradeValid =
        Grade.validate(event.grade).grade.isRight();
    final isUniversityValid =
         University.validate(event.university).university.isRight();
    final isYEOValid =
     YearOfExperience.validate(event.yearOfExperience).yearOfExperinece.isRight();
    

    if (!event.education.isNotEmpty) {
      emit(const EducationInfoValidFailedState("Please select your highest education"));
    } 
    else if (!event.yearOfPassing.isNotEmpty) {
      emit(const EducationInfoValidFailedState("Please select year of passing"));
     }
    else if (!isGradeValid) {
      emit(const EducationInfoValidFailedState("Please enter Valid Grade"));
    }
    else if (!isUniversityValid) {
      emit(const EducationInfoValidFailedState(
          "Please enter University"));
    }
    else if (!isYEOValid) {
      emit(const EducationInfoValidFailedState(
          "Please Enter years of experience"));
    } 
    else if (!event.designation.isNotEmpty) {
     emit(const EducationInfoValidFailedState("Please select designation"));
    }  
    else{
      emit(EducationInfoValidState());
    }

  }

     void validateAddressForm(
     AddAddressEvent  event, Emitter<RegFormState> emit) async {
  final isAddressValid =
        Address.validate(event.address).address.isRight();
    final islandMarkValid =
         Locality.validate(event.landmark).locality.isRight();
    final isCityValid =
     City.validate(event.city).city.isRight();
    final isZipCodeValid =
        ZipCode.validate(event.zipcode).zipCode.isRight();
    

    if (!isAddressValid) {
      emit(const AddresValidFailedState("Please enter valid address"));
    } 
    else if (!islandMarkValid) {
      emit(const AddresValidFailedState("Please enter landmark"));
     }
    else if (!isCityValid) {
      emit(const AddresValidFailedState("Please enter city"));
    }
    else if (!event.state.isNotEmpty) {
      emit(const AddresValidFailedState(
          "Please select state"));
    }
    else if (!isZipCodeValid) {
      emit(const AddresValidFailedState(
          "Please Enter valid zipcode"));
    } 
    
    else{
      emit(AddresValidState());
    }

  }

  void reset(ResetEvent event, Emitter<RegFormState> emit) {
    emit(InitialState());
  }
}
