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
import 'package:nutrilog/app/core/utils/validators.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final authStore = Modular.get<AuthStore>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => authStore.signinState, (SigninState state) async {
        if (state is SigninErrorState) {
          errorToast(context, state.message);
        } else if (state is SigninSuccessState) {
          Modular.to.navigate('/entry/home/');
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
            child: Column(
              children: [
                SizedBox(height: 350, child: Center(child: Image.asset(Assets.logo))),
                const SizedBox(height: 16),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          onTap: () => authStore.passwordIsHidden = !authStore.passwordIsHidden,
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
                            onTap: () => Modular.to.pushNamed('signup'),
                            child: const AdaptiveText(
                              text: 'Ainda não possui cadastro? Clique aqui.',
                              textType: TextType.nano,
                              textDecoration: TextDecoration.underline,
                              color: CColors.neutral600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      CustomButton.primaryNeutroMedium(ButtonParameters(
                        text: 'Fazer login',
                        isLoading: authStore.signinState is SigninLoadingState,
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            authStore.signin(
                              AuthPayloadModel(
                                email: emailTextController.text.trim(),
                                password: passwordTextController.text.trim(),
                              ),
                            );
                          } else {
                            warningToast(context, "Preencha os campos corretamente");
                          }
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
