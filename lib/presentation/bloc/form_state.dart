part of 'form_bloc.dart';

sealed class RegFormState extends Equatable {
  const RegFormState();
  
  @override
  List<Object> get props => [];
}

final class RegisterValidState extends RegFormState {}
final class RegisterValidFailedState extends RegFormState {
  final String message;

  const RegisterValidFailedState(this.message);

  String get error=>message;
}
final class EducationInfoValidState extends RegFormState {}
final class EducationInfoValidFailedState extends RegFormState {
    final String message;

  const EducationInfoValidFailedState(this.message);

  String get error=>message;

}
final class AddresValidState extends RegFormState {}
final class AddresValidFailedState extends RegFormState {
      final String message;

  const AddresValidFailedState(this.message);

  String get error=>message;
}
final class InitialState extends RegFormState {}


