import 'package:assignment/presentation/bloc/form_bloc.dart';
import 'package:assignment/presentation/cubit/designationdrp_cubit.dart';
import 'package:assignment/presentation/cubit/domaindrp_cubit.dart';
import 'package:assignment/presentation/cubit/euducationdrp_cubit.dart';
import 'package:assignment/presentation/cubit/passing_yeardrp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'address_page.dart';
import 'widgets/custom_textfield.dart';

class EducationInfoPage extends StatefulWidget {
  const EducationInfoPage({super.key});

  @override
  State<EducationInfoPage> createState() => _EducationInfoPageState();
}

class _EducationInfoPageState extends State<EducationInfoPage> {
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController yOEController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  
   
  @override
  void dispose() {
    gradeController.dispose();
    yOEController.dispose();
    universityController.dispose();
  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<FormBloc>(context);
    final educationDrpBloc = BlocProvider.of<EducationDrpCubit>(context);
    final passingYearDrpBloc = BlocProvider.of<PassingYearDrpCubit>(context);
    final designationDrpBloc = BlocProvider.of<DesignationDrpCubit>(context);
    final domainDrpBloc = BlocProvider.of<DomianDrpCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Info"),
      ),
      body: BlocListener<FormBloc, RegFormState>(
        bloc: formBloc,
        listener: (context, state) {
          if (state is EducationInfoValidState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddressPage(),
                ));

            formBloc.add(ResetEvent());
          } else if (state is EducationInfoValidFailedState) {
            var snackBar = SnackBar(
              content: Text(state.message),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            formBloc.add(ResetEvent());
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal:30.0),
                   child: Text(
                            "Educational Info",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                 ),
              BlocConsumer<EducationDrpCubit, String?>(
                bloc: educationDrpBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Education*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: DropdownButton<String?>(padding: EdgeInsets.symmetric(horizontal: 10),
                            underline: const SizedBox(),
                            value: state,
                            hint: const Text(
                              "Select Your Qualification",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                        
                            items: ["Post Graduate", "Graduate", "HSC/Diploma", "SSC"].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              educationDrpBloc.toggle(newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              
                 BlocConsumer<PassingYearDrpCubit, String?>(
                bloc: passingYearDrpBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Year of Passing*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: DropdownButton<String?>(padding: EdgeInsets.symmetric(horizontal: 10),
                            underline: const SizedBox(),
                            value: state,
                            hint: const Text(
                              "Enter year of passing",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                        
                            items: ["2019", "2020", "2021", "2022","2023",].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              passingYearDrpBloc.toggle(newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              
              CustomTextField(
                  controller: gradeController,
                  icon:null,
                  labelText: "Grade*",
                  hintText: "Enter your grade or percentage"),
                      CustomTextField(
                  controller: universityController,
                  icon: null,
                  labelText: "Univeristy",
                  hintText: "Enter the University"),
                 const Divider(thickness: 1,color: Colors.grey,endIndent: 20,indent: 20,),
             
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal:30.0),
                   child: Text(
                            "Professional Info",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                 ),
              CustomTextField(
                  controller: yOEController,
                  icon: null,
                  labelText: "Experience*",
                  hintText: "Enter the years of experience"),


                          BlocConsumer<DesignationDrpCubit, String?>(
                bloc: designationDrpBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Designation*",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: DropdownButton<String?>(padding: EdgeInsets.symmetric(horizontal: 10),
                            underline: const SizedBox(),
                            value: state,
                            hint: const Text(
                              "Select Designation",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                        
                            items: ["Software Engineer", "Sr.Software Engineeer", "Assiatant Manager", "Devops Manager"].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              designationDrpBloc.toggle(newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

                             BlocConsumer<DomianDrpCubit, String?>(
                bloc: domainDrpBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Domain",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: DropdownButton<String?>(padding: EdgeInsets.symmetric(horizontal: 10),
                            underline: const SizedBox(),
                            value: state,
                            hint: const Text(
                              "Select Domain",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                        
                            items: ["IOT", "Big Data", "AI", "Eccomerce"].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              domainDrpBloc.toggle(newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          
             
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                         Expanded(
                           child: Padding(
                                         padding:
                                             const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                                         child: ElevatedButton(
                                           onPressed: () {
                                            Navigator.pop(context);
                                           },
                                           style: ElevatedButton.styleFrom(
                                               backgroundColor: Colors.white,
                                              minimumSize: const Size(100, 50),
                                               shape: const BeveledRectangleBorder()),
                                           child: const Text(
                                             'Previous',
                                             style: TextStyle(color: Colors.blue),
                                           ),
                                         ),
                                       ),
                         ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          formBloc.add(AddInfoEvent(designation: designationDrpBloc.state??"",yearOfPassing: passingYearDrpBloc.state??"",grade: gradeController.text ,university: universityController.text,
                            education: educationDrpBloc.state??"", yearOfExperience: yOEController.text,domain: domainDrpBloc.state??""));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                           minimumSize: const Size(100, 50),
                            shape: const BeveledRectangleBorder()),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
