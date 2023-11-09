import 'dart:io';

import 'package:assignment/presentation/bloc/form_bloc.dart';
import 'package:assignment/presentation/cubit/gender_cubit.dart';
import 'package:assignment/presentation/cubit/image_cubit.dart';
import 'package:assignment/presentation/cubit/obscure_text_cubit.dart';
import 'package:assignment/presentation/ui/education_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/custom_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Gender grpName = Gender.male;
  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  File? image;
  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      final imageTemp = File(image.path);
      return imageTemp;
      // setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  Future<File?> pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
      final imageTemp = File(image.path);
      return imageTemp;
      // setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<FormBloc>(context);
    final obscureTextBloc = BlocProvider.of<ObscureTextCubit>(context);
    final imageFileBloc = BlocProvider.of<ImageFileCubit>(context);
    final genderBloc = BlocProvider.of<GenderCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register"),
      ),
      body: BlocListener<FormBloc, RegFormState>(
        bloc: formBloc,
        listener: (context, state) {
          if (state is RegisterValidState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EducationInfoPage(),
                ));

            formBloc.add(ResetEvent());
          } else if (state is RegisterValidFailedState) {
            var snackBar = SnackBar(
              content: Text(state.message),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            formBloc.add(ResetEvent());
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  BlocConsumer<ImageFileCubit, File?>(
                    bloc: imageFileBloc,
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      return state == null
                          ? const CircleAvatar(
                              minRadius: 50,
                              child: Icon(Icons.person),
                            )
                          : CircleAvatar(child: Image.file(state));
                    },
                    listener: (BuildContext context, File? state) {},
                  ),
                  Positioned(
                      right: 140,
                      bottom: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    final file = await pickImageC();
                                                    imageFileBloc.addFile(file);
                                                  },
                                                  icon: const Icon(Icons.camera)),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                final file = await pickImage();
                                                imageFileBloc.addFile(file);
                                              },
                                              icon: const Icon(
                                                  Icons.filter_sharp))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );

                            },
                            icon: const Icon(
                              Icons.edit,
                            )),
                      ))
                ],
              ),
              CustomTextField(
                  controller: fnameController,
                  icon: const Icon(Icons.person),
                  labelText: "First Name*",
                  hintText: "Enter your first name here"),
              CustomTextField(
                  controller: lnameController,
                  icon: const Icon(Icons.person),
                  labelText: "Last Name*",
                  hintText: "Enter your last name here"),
              CustomTextField(
                  controller: phoneController,
                  icon: const Icon(Icons.call),
                  labelText: "Phone Number*",
                  hintText: "Enter your 10 digit phone number"),
              CustomTextField(
                  controller: emailController,
                  icon: const Icon(Icons.mail),
                  labelText: "Email*",
                  hintText: "Your email goes here"),
              BlocConsumer<GenderCubit, Gender>(
                bloc: genderBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text("Gender",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),),
                        SizedBox(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Radio<Gender>(
                                      value: Gender.male,
                                      groupValue: state,
                                      onChanged: (Gender? value) {
                                        genderBloc.toggle(value!);
                                      },
                                    ),
                                    const Expanded(
                                      child: Text('Male'),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Radio<Gender>(
                                      value: Gender.female,
                                      groupValue: state,
                                      onChanged: (Gender? value) {
                                        genderBloc.toggle(value!);
                                      },
                                    ),
                                    const Expanded(child: Text('Female'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              BlocConsumer<ObscureTextCubit, bool>(
                buildWhen: (previous, current) => previous != current,
                bloc: obscureTextBloc,
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordController,
                    icon: const Icon(Icons.lock),
                    labelText: "Password*",
                    hintText: "Password",
                    isObscure: state,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          obscureTextBloc.toggle();
                        }),
                  );
                },
              ),
              CustomTextField(
                  controller: confirmPasswordController,
                  icon: const Icon(Icons.lock),
                  labelText: "Confirm Password",
                  hintText: "Password"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    formBloc.add(RegisterEvent(
                        phoneNumber: phoneController.text,
                        confirmpassword: confirmPasswordController.text,
                        emailAddress: emailController.text,
                        firstName: fnameController.text,
                        lastName: lnameController.text,
                        password: passwordController.text));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const BeveledRectangleBorder()),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}







