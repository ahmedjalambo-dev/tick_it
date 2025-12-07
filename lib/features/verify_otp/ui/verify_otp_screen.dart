import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tick_it/core/theme/my_theme.dart';
import 'package:tick_it/core/widgets/my_otp_form_field.dart';
import 'package:tick_it/core/widgets/my_text_button.dart';
import 'package:tick_it/core/widgets/spacing_widgets.dart';
import 'package:tick_it/features/verify_otp/cubit/verify_otp_cubit.dart';
import 'widgets/verify_otp_bloc_listener.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  bool isOtpComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Verify Email")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Code",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const VerticalSpace(8),
              Text(
                "We sent a 6-digit code to ${widget.email}",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const VerticalSpace(32),
              MyOtpFormField(
                length: 6,
                onChanged: (value) {
                  context.read<VerifyOtpCubit>().otpController.text = value;
                  setState(() {
                    isOtpComplete = value.length == 6;
                  });
                },
                onCompleted: (value) {
                  context.read<VerifyOtpCubit>().otpController.text = value;
                  setState(() {
                    isOtpComplete = true;
                  });
                },
              ),
              const VerticalSpace(24),
              MyTextButton(
                text: "Verify",
                onPressed: isOtpComplete
                    ? () {
                        context.read<VerifyOtpCubit>().emitVerifyOtpState();
                      }
                    : () {},
                backgroundColor: MyTheme.darkTheme.colorScheme.primary,
              ),
              const VerifyOtpBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
