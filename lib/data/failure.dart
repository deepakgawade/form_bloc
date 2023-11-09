
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.invalidEmail({
    required String failedValue,
  }) = _InvalidEmail;

  const factory Failure.firstname({
    required String failedValue,
  }) = _FirstName;

    const factory Failure.lastname({
    required String failedValue,
  }) = _LastName;
      const factory Failure.shortPassword({
    required String failedValue,
  }) = _ShortPassword;
        const factory Failure.invalidPhone({
    required String failedValue,
  }) = _InvalidPhone;

          const factory Failure.invalidYear({
    required String failedValue,
  }) = _InvalidYear;
         const factory Failure.invalidGrade({
    required String failedValue,
  }) = _InvalidGrade;

           const factory Failure.invalidUniversity({
    required String failedValue,
  }) = _InvalidUniversity;

             const factory Failure.invalidYEO({
    required String failedValue,
  }) = _InvalidYEO;

               const factory Failure.invalidAddress({
    required String failedValue,
  }) = _InvalidAddress;
                 const factory Failure.invalidLocality({
    required String failedValue,
  }) = _InvalidLocality;

                   const factory Failure.invalidZipCode({
    required String failedValue,
  }) = _InvalidZipCode;


                   const factory Failure.invalidCity({
    required String failedValue,
  }) = _InvalidCity;

}