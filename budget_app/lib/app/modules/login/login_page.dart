import 'package:budget_app/app/components/budget_button.dart';
import 'package:budget_app/app/components/budget_text_form_field.dart';
import 'package:budget_app/app/core/store_state.dart';
import 'package:budget_app/app/mixins/loader_mixin.dart';
import 'package:budget_app/app/utils/size_utils.dart';
import 'package:budget_app/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController>
    with LoaderMixin {
  List<ReactionDisposer> _disposer;

  @override
  void initState() {
    super.initState();
    _disposer ??= [
      reaction((_) => controller.state, (StoreState state) {
        if (state == StoreState.loading) {
          showLoader();
        } else if (state == StoreState.loaded) {
          hideLoader();
        }
      }),
      reaction((_) => controller.loginSuccess, (sucess) {
        if (sucess != null) {
          if (sucess) {
            Get.offAllNamed('/movimentacoes');
          } else {
            Get.snackbar('Erro ao realizar Login', 'Login ou senha inválidos',
                backgroundColor: Colors.white);
          }
        }
      }),
      reaction((_) => controller.errorMessage, (String errorMessage) {
        if (errorMessage.isNotEmpty) {
          hideLoader();
          Get.snackbar('Erro ao realizar Login', errorMessage,
              backgroundColor: Colors.white);
        }
      })
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposer.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _makeHeader(),
            SizedBox(
              height: 30,
            ),
            _makeForm()
          ],
        ),
      ),
    );
  }

  Widget _makeHeader() {
    return Container(
      color: ThemeUtils.primaryColor,
      width: SizeUtils.widthScreen,
      height: (SizeUtils.heightScreen * .5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 50,
            child: Image.asset('assets/images/logo.png'),
          )
        ],
      ),
    );
  }

  Form _makeForm() {
    return Form(
      key: controller.globalKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            BudgetTextFormField(
              label: 'Login',
              onChanged: (String valor) => controller.changeLogin(valor),
              validator: (String valor) {
                if (valor.isEmpty) {
                  return 'Login obrigatório';
                }

                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            BudgetTextFormField(
              label: 'Senha',
              onChanged: (String valor) => controller.changeSenha(valor),
              validator: (String valor) {
                if (valor.isEmpty) {
                  return 'Senha obrigatória';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            BudgetButton(
              label: 'Entrar',
              onPressed: () => controller.requestLogin(),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () => Get.toNamed('/login/cadastro'),
              child: Text(
                'Cadastre-se',
                style: TextStyle(
                  color: ThemeUtils.primaryColor,
                  fontSize: 20,
                ),
              ),
            ),SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
