import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/register_controller.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/services/services.dart';
import 'package:tic_tac_toe_app/views/dialogs/register_dialog.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = RegisterController();
  final controll = Services();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                top(),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            input(
                                "Nome",
                                "Usuario_123",
                                const Icon(Icons.person),
                                TextInputAction.next,
                                controller.validateName,
                                controller.nameController),
                            const SizedBox(
                              height: 20,
                            ),
                            input(
                                "Telefone",
                                " (11) 91234-5678",
                                const Icon(
                                  Icons.phone,
                                ),
                                TextInputAction.next,
                                textinputtype:
                                    const TextInputType.numberWithOptions(),
                                controller.validatePhone,
                                controller.phoneController),
                            const SizedBox(
                              height: 20,
                            ),
                            input(
                                "E-mail",
                                "usuario@gmail.com",
                                const Icon(Icons.email),
                                TextInputAction.next,
                                controller.validateEmail,
                                controller.emailController),
                            const SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<bool>(
                                stream: controller.streamObscureText,
                                builder: (context, snapshot) {
                                  return input(
                                    "Senha",
                                    "Senha@2025",
                                    touch(),
                                    TextInputAction.next,
                                    controller.validatePass,
                                    controller.passController,
                                    obcureText: controller.isconfirmed,
                                  );
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            StreamBuilder<bool>(
                                stream: controller.streamObscureText,
                                builder: (context, snapshot) {
                                  return input(
                                      "Confirmar Senha",
                                      "Repita sua senha",
                                      touch(),
                                      TextInputAction.done,
                                      controller.confirmPass,
                                      controller.confirmController,
                                      obcureText: controller.isconfirmed,
                                      onField: () async {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      await controll.setUser(
                                          controller, context);
                                    }
                                  });
                                }),
                            const SizedBox(height: 20),
                            cadasterButton()
                          ],
                        ),
                      ),
                    )),
                const WavyContainer(postionWavy: PositionWavy.top)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget input(
    String labelText,
    String heinText,
    icon,
    TextInputAction textinputactions,
    String? Function(String?)? validator,
    TextEditingController control, {
    bool obcureText = false,
    TextInputType? textinputtype,
    Future<void> Function()? onField,
  }) {
    return TextFormField(
        decoration: InputDecoration(
            suffixIcon: icon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: labelText,
            hintText: heinText,
            labelStyle: const TextStyle(color: AppColors.blueColor),
            hintStyle: const TextStyle(color: AppColors.blueColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.blueColor, width: 3))),
        obscureText: obcureText,
        validator: validator,
        controller: control,
        textInputAction: textinputactions,
        keyboardType: textinputtype,
        onFieldSubmitted: (_) async {
          if (onField != null) {
            await onField();
          }
        });
  }

  Widget top() {
    return WavyContainer(
      postionWavy: PositionWavy.bottom,
      child: SizedBox(
        height: 180,
        width: double.maxFinite,
        child: Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                )),
          ),
        ),
      ),
    );
  }

  Widget touch() {
    return InkWell(
      onTap: () {
        controller.obscureText();
      },
      child: controller.isconfirmed
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.remove_red_eye),
    );
  }

  Widget cadasterButton() {
    return ElevatedButton(
        onPressed: () async {
          if (controller.formKey.currentState!.validate()) {
            await controll.setUser(controller, context);
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueColor,
            minimumSize: const Size(double.maxFinite, 56),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            )),
        child: const Text(
          "Cadastrar",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }
}
