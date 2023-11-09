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
                      return image == null
                          ? const CircleAvatar(
                              minRadius: 50,
                              child: Icon(Icons.person),
                            )
                          : CircleAvatar(child: Image.file(image!));
                    },
                    listener: (BuildContext context, File? state) {},
                  ),
                  //const  ImageViewer(),
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
                                          IconButton(
                                              onPressed: () async {
                                                final file = await pickImageC();
                                                imageFileBloc.addFile(file);
                                              },
                                              icon: const Icon(Icons.camera)),
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

                              // final file  = await pickImage();

                              // imageFileBloc.addFile(file);
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
                          //width: 350, //height: 400,
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

// class ImageViewer extends StatefulWidget {
//   const ImageViewer({
//     super.key,
//   });

//   @override
//   State<ImageViewer> createState() => _ImageViewerState();
// }

// class _ImageViewerState extends State<ImageViewer> {

//     final ImagePicker _picker = ImagePicker();
//  List<XFile>? _mediaFileList;
//    dynamic _pickImageError;
//   String? _retrieveDataError;


//   void _setImageFileListFromFile(XFile? value) {
//     _mediaFileList = value == null ? null : <XFile>[value];
//   }

//   Future<void> _onImageButtonPressed(
//     ImageSource source, {
//     required BuildContext context,
//     bool isMultiImage = false,
//     bool isMedia = false,
//   }) async {
 
//     if (context.mounted) {
//    if (isMedia) {
//         await _displayPickImageDialog(context,
//             (double? maxWidth, double? maxHeight, int? quality) async {
//           try {
//             final List<XFile> pickedFileList = <XFile>[];
//             final XFile? media = await _picker.pickMedia(
//               maxWidth: maxWidth,
//               maxHeight: maxHeight,
//               imageQuality: quality,
//             );
//             if (media != null) {
//               pickedFileList.add(media);
//               setState(() {
//                 _mediaFileList = pickedFileList;
//               });
//             }
//           } catch (e) {
//             setState(() {
//               _pickImageError = e;
//             });
//           }
//         });
//       } else {
//         await _displayPickImageDialog(context,
//             (double? maxWidth, double? maxHeight, int? quality) async {
//           try {
//             final XFile? pickedFile = await _picker.pickImage(
//               source: source,
//               maxWidth: maxWidth,
//               maxHeight: maxHeight,
//               imageQuality: quality,
//             );
//             setState(() {
//               _setImageFileListFromFile(pickedFile);
//             });
//           } catch (e) {
//             setState(() {
//               _pickImageError = e;
//             });
//           }
//         });
//       }
//     }
//   }
//   Future<void> retrieveLostData() async {
//     final LostDataResponse response = await _picker.retrieveLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
     
       
//         setState(() {
//           if (response.files == null) {
//             _setImageFileListFromFile(response.file);
//           } else {
//             _mediaFileList = response.files;
//           }
//         });
      
//     } else {
//       _retrieveDataError = response.exception!.code;
//     }
//   }

//     Future<void> _displayPickImageDialog(
//       BuildContext context, OnPickImageCallback onPick) async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Add optional parameters'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
              
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () {
//                     // final double? width = maxWidthController.text.isNotEmpty
//                     //     ? double.parse(maxWidthController.text)
//                     //     : null;
//                     // final double? height = maxHeightController.text.isNotEmpty
//                     //     ? double.parse(maxHeightController.text)
//                     //     : null;
//                     // final int? quality = qualityController.text.isNotEmpty
//                     //     ? int.parse(qualityController.text)
//                     //     : null;
//                     onPick(50, 50, 1);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
  
//  Text? _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError!);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
//  Widget _previewImages() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_mediaFileList != null) {
//       return Semantics(
//         label: 'image_picker_example_picked_images',
//         child: ListView.builder(
//           key: UniqueKey(),
//           itemBuilder: (BuildContext context, int index) {

          
//             return Semantics(
//               label: 'image_picker_example_picked_image',
//               child: Image.file(
//                           File(_mediaFileList![index].path),
//                           errorBuilder: (BuildContext context, Object error,
//                               StackTrace? stackTrace) {
//                             return const Center(
//                                 child:
//                                     Text('This image type is not supported'));
//                           },
//                         )
//             );
//           },
//           itemCount: _mediaFileList!.length,
//         ),
//       );
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//                              return CircleAvatar(child: IconButton(onPressed: (){_onImageButtonPressed(ImageSource.gallery, context: context);},iconSize: 50, icon: Icon(Icons.person),),minRadius: 50,);
// ;
//     }
//   }
//  Widget _handlePreview() {
    
//       return _previewImages();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//    return  Center(
//         child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//                 future: retrieveLostData(),
//                 builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.none:
//                     case ConnectionState.waiting:
//                       return                           CircleAvatar(child: IconButton(onPressed: (){_onImageButtonPressed(ImageSource.gallery, context: context);}, icon: Icon(Icons.person)),);
// ;
//                     case ConnectionState.done:
//                       return _handlePreview();
//                     case ConnectionState.active:
//                       if (snapshot.hasError) {
//                         return Text(
//                           'Pick image/video error: ${snapshot.error}}',
//                           textAlign: TextAlign.center,
//                         );
//                       } else {
//                         return CircleAvatar(child: IconButton(onPressed: (){_onImageButtonPressed(ImageSource.gallery, context: context);}, icon: Icon(Icons.person)),);
//                       }
//                   }
//                 },
//               )
//             : _handlePreview(),
//       );
//   }



// }

//   typedef OnPickImageCallback = void Function(
//     double? maxWidth, double? maxHeight, int? quality);







