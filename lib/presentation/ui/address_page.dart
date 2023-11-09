import 'package:assignment/presentation/cubit/state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/form_bloc.dart';
import 'widgets/custom_textfield.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    localityController.dispose();
    cityController.dispose();
    zipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<FormBloc>(context);
    final stateBloc = BlocProvider.of<StateCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Address"),
      ),
      body: BlocListener<FormBloc, RegFormState>(
        bloc: formBloc,
        listener: (context, state) {
          if (state is AddresValidState) {
            const snackBar = SnackBar(backgroundColor: Colors.green,
              content:  Text("Registration succesful",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            formBloc.add(ResetEvent());
          } else if (state is AddresValidFailedState) {
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
              CustomTextField(
                  controller: addressController,
                  icon: const Icon(Icons.location_city),
                  hintText: "Address"),
              CustomTextField(
                  controller: localityController,
                  icon: const Icon(Icons.location_city),
                  hintText: "Landmark"),
              CustomTextField(
                  controller: cityController,
                  icon: const Icon(Icons.location_city),
              
                  hintText: "City"),

                    BlocConsumer<StateCubit, String?>(
                bloc: stateBloc,
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: DropdownButton<String?>(padding: EdgeInsets.symmetric(horizontal: 10),
                            underline: const SizedBox(),
                            value: state,
                            hint: const Text(
                              "State",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),

                        
                            items: ["Maharashtra", "Gujarat", "Karnataka", "Madhya Pradesh","Delhi","Others"].map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              stateBloc.toggle(newValue!);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

             CustomTextField(
                  controller: zipController,
                  icon: const Icon(Icons.location_city),
              
                  hintText: "Pin Code"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                child: ElevatedButton(
                  onPressed: () {
                    formBloc.add(AddAddressEvent(address: addressController.text, landmark: localityController.text, city: cityController.text, state: stateBloc.state??"", zipcode: zipController.text));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const BeveledRectangleBorder()),
                  child: const Text(
                    'Submit',
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
