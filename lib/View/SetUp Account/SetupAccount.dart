import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_bloc.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_event.dart';
import 'package:taxi_app/Bloc/setUpBloc/set_up_account_state.dart';
import 'package:taxi_app/Utils/flushbar_helper.dart';
import 'package:taxi_app/config/Color/Colors.dart';
import 'package:taxi_app/config/Routes/Routes_name.dart';

class SetUpAccount extends StatefulWidget {
  const SetUpAccount({super.key});

  @override
  State<SetUpAccount> createState() => _SetUpAccountState();
}

class _SetUpAccountState extends State<SetUpAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Account'),
      ),
      body: BlocConsumer<AccountSetupBloc, AccountSetupState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // Navigate back or to another screen
            Navigator.pushNamed(context, RoutesName.googleMap);
            showSuccessfullyFlushbar(context, 'Account Created Successfully');
          } else if (state.isFailure) {
            showErrorFlushbar(context, 'SomeThing went Wrong!');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fill the details below...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            context
                                .read<AccountSetupBloc>()
                                .add(FirstNameChanged(value));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            context
                                .read<AccountSetupBloc>()
                                .add(LastNameChanged(value));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<AccountSetupBloc>().add(EmailChanged(value));
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: AppColor.cityBlue,
                      child:  Icon(Icons.check, color:AppColor.cityWhite),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AccountSetupBloc>()
                              .add(SubmitAccountSetup());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
