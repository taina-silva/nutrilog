import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/fields/common_field.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/auth/auth_payload_model.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/status_bar_theme.dart';
import 'package:nutrilog/app/core/utils/validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final authStore = Modular.get<AuthStore>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();
    changeStatusBarTheme(StatusBarTheme.light, CColors.primaryNutrition);

    reactions = [
      reaction((_) => authStore.signupState, (SignupState state) async {
        if (state is SignupErrorState) {
          errorToast(context, state.message);
        } else if (state is SignupSuccessState) {
          Modular.to.pop();
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CustomScaffold(
        backgroundColor: CColors.primaryNutrition,
        body: Observer(builder: (context) {
          return Column(
            children: [
              const SizedBox(height: 80),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: DefaultMargin.horizontal,
                    vertical: 2 * DefaultMargin.horizontal,
                  ),
                  decoration: const BoxDecoration(
                    color: CColors.neutral0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(child: Image.asset(Assets.logo, width: 240)),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Form(
                          key: formKey,
                          child: ListView(
                            children: [
                              const AdaptiveText(text: 'E-mail', textType: TextType.medium),
                              CommonField(
                                placeholder: 'abc@def.com',
                                validator: Validators.emailValidator,
                                controller: emailTextController,
                              ),
                              const SizedBox(height: 24),
                              const AdaptiveText(text: 'Senha', textType: TextType.medium),
                              CommonField(
                                placeholder: 'Digite sua senha',
                                obscure: authStore.passwordIsHidden,
                                validator: Validators.passwordValidator,
                                controller: passwordTextController,
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      authStore.passwordIsHidden = !authStore.passwordIsHidden,
                                  child: Icon(authStore.passwordIsHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const AdaptiveText(
                                  text: 'Confirmar senha', textType: TextType.medium),
                              CommonField(
                                placeholder: 'Digite sua senha novamente',
                                obscure: authStore.passwordIsHidden,
                                validator: (confirmPassword) {
                                  return Validators.confirmPasswordValidator(
                                      confirmPassword, passwordTextController.text);
                                },
                                controller: confirmPasswordTextController,
                                suffixIcon: GestureDetector(
                                  onTap: () =>
                                      authStore.passwordIsHidden = !authStore.passwordIsHidden,
                                  child: Icon(authStore.passwordIsHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => Modular.to.pop(),
                                    child: const AdaptiveText(
                                      text: 'Já possui cadastro? Clique aqui.',
                                      textType: TextType.nano,
                                      textDecoration: TextDecoration.underline,
                                      color: CColors.neutral600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 48),
                              CustomButton.primaryNeutroMedium(ButtonParameters(
                                text: 'Realizar cadastro',
                                isLoading: authStore.signupState is SignupLoadingState,
                                onTap: () {
                                  if (!(formKey.currentState?.validate() ?? false)) {
                                    warningToast(context, "Preencha os campos corretamente");
                                    return;
                                  }

                                  authStore.signup(
                                    AuthPayloadModel(
                                      email: emailTextController.text.trim(),
                                      password: passwordTextController.text.trim(),
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
