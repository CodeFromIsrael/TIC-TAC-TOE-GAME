import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/login_controller.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';
import 'package:tic_tac_toe_app/services/services.dart';
import 'package:tic_tac_toe_app/views/screens/home_screen.dart';
import 'package:tic_tac_toe_app/views/screens/register_screen.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class LoginScrenn extends StatefulWidget {
  const LoginScrenn({super.key});

  @override
  State<LoginScrenn> createState() => _LoginScrennState();
}

class _LoginScrennState extends State<LoginScrenn> {
  final controller = LoginController();
  final controll = Services();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    log("${controller.loadUser()}");
    controller.loadUser();
    controller.loadButtonState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WavyContainer(
                    postionWavy: PositionWavy.bottom,
                  ),
                  Image.asset(
                    AppImages.tictactoe,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          input(
                              'E-mail',
                              controller.validateEmail,
                              const Icon(Icons.email),
                              controller.emailController),
                          const SizedBox(height: 14),
                          StreamBuilder<bool>(
                              stream: controller.streamObscureText,
                              builder: (context, snapshot) {
                                return input(
                                  "Senha",
                                  controller.validatePass,
                                  touchFunction(),
                                  controller.passController,
                                  obscureText: controller.hideText,
                                );
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<bool>(
                                stream: controller.streamtouch,
                                builder: (context, snapshot) {
                                  return remenberUser();
                                },
                              ),
                              Flexible(
                                child: textButton(
                                    const Text(
                                      "Esqueceu a Senha ?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.blueColor),
                                    ),
                                    () {}),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          enterButton(),
                          const SizedBox(
                            height: 10,
                          ),
                          textButton(
                              const Text(
                                "Criar Conta",
                                style: TextStyle(
                                    color: AppColors.blueColor, fontSize: 18),
                              ), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          }),
                        ],
                      ),
                    ),
                  ),
                  const WavyContainer(postionWavy: PositionWavy.top),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget input(String label, String? Function(String?)? validator, icon,
      TextEditingController control,
      {bool obscureText = false}) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.blueColor),
        hintStyle: const TextStyle(color: AppColors.blueColor),
        suffixIcon: icon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blueColor, width: 3),
        ),
      ),
      validator: validator,
      obscureText: obscureText,
      controller: control,
    );
  }

  Widget top() {
    return const WavyContainer(
      postionWavy: PositionWavy.bottom,
    );
  }

  Widget remenberUser() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.touch();
            // controller.loadUser();
            //controller.saveUser();
            // controller.loadButtonState();
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(),
                color: controller.isConfirmed
                    ? AppColors.blueColor
                    : AppColors.blueColor.withOpacity(0.2)),
            child: controller.isConfirmed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
          ),
        ),
        TextButton(
          onPressed: () {
            controller.touch();
          },
          child: const Text(
            "Lembrar Usuário",
            style: TextStyle(color: AppColors.blueColor, fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget textButton(Widget text, function) {
    return TextButton(onPressed: function, child: text);
  }

  Widget touchFunction() {
    return InkWell(
        onTap: () {
          controller.obscureText();
        },
        child: controller.hideText
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.remove_red_eye));
  }

  Widget enterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (controller.formKey.currentState!.validate()) {
          await controll.loginUser(controller, context);
          ServiceController.checkLogin();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        minimumSize: const Size(double.maxFinite, 58),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text(
        "Entrar",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
