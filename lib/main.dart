import 'package:assignment/presentation/bloc/form_bloc.dart';
import 'package:assignment/presentation/cubit/designationdrp_cubit.dart';
import 'package:assignment/presentation/cubit/domaindrp_cubit.dart';
import 'package:assignment/presentation/cubit/euducationdrp_cubit.dart';
import 'package:assignment/presentation/cubit/gender_cubit.dart';
import 'package:assignment/presentation/cubit/image_cubit.dart';
import 'package:assignment/presentation/cubit/obscure_text_cubit.dart';
import 'package:assignment/presentation/cubit/passing_yeardrp_cubit.dart';
import 'package:assignment/presentation/cubit/state_cubit.dart';
import 'package:assignment/presentation/ui/address_page.dart';
import 'package:assignment/presentation/ui/education_info_page.dart';
import 'package:assignment/presentation/ui/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FormBloc(),
        ),
        BlocProvider(
          create: (context) => ObscureTextCubit(),
        ),  BlocProvider(
          create: (context) => ImageFileCubit(),
        ),
         BlocProvider(
          create: (context) => GenderCubit(),
        ),
        BlocProvider(
          create: (context) => EducationDrpCubit(),
        ),
           BlocProvider(
          create: (context) => PassingYearDrpCubit(),
        ),
                 BlocProvider(
          create: (context) => DomianDrpCubit(),
        ),
                 BlocProvider(
          create: (context) => DesignationDrpCubit(),
        ),
                BlocProvider(
          create: (context) => StateCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegistrationPage(),
      ),
    );
  }
}




