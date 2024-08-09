import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_event.dart';

import '../../Bloc/setUpBloc/set_up_account_bloc.dart'; // Import your Bloc file

class SetUpAccount extends StatefulWidget {
  const SetUpAccount({super.key});

  @override
  State<SetUpAccount> createState() => _SetUpAccountState();
}

class _SetUpAccountState extends State<SetUpAccount> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(title: const  Text('Set Up Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const  Text('Fill the details below...', style: TextStyle(fontSize: 16)),
              SizedBox(height: height * .02),
              TextFormField(
                decoration:const  InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  BlocProvider.of<AccountSetupBloc>(context).add(
                    FirstNameChanged(value),
                  );
                },
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: height * .02),
              TextFormField(
                decoration:const  InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  BlocProvider.of<AccountSetupBloc>(context).add(
                    LastNameChanged(value),
                  );
                },
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: height * .02),
              TextFormField(
                decoration:const  InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  BlocProvider.of<AccountSetupBloc>(context).add(
                    EmailChanged(value),
                  );
                },
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child:const  Icon(Icons.check),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AccountSetupBloc>(context).add(
                        SubmitAccountSetup(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
