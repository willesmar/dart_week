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
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends ModularState<CadastroPage, CadastroController>
    with LoaderMixin {
  List<ReactionDisposer> disposers;
  AppBar appBar = AppBar(
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();
    disposers ??= [
      reaction((_) => controller.state, (StoreState state) {
        print(state);
        if (state == StoreState.loading) {
          showLoader();
        } else if (state == StoreState.loaded) {
          hideLoader();
          Get.snackbar('Sucesso', 'Login cadastrado com sucesso');
          Get.offAllNamed('/login');
        }
      }),
      reaction((_) => controller.errorMessage, (String message) {
        print(message);
        if (message.isNotEmpty) {
          hideLoader();
          Get.snackbar('Erro ao realizar o login', message,
              backgroundColor: Colors.white);
        }
      })
    ];
  }

  @override
  void dispose() {
    super.dispose();
    disposers.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
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
      height: ((SizeUtils.heightScreen * .5) -
          (SizeUtils.statusBarHeight + appBar.preferredSize.height)),
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
              onChanged: controller.changeLogin,
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
              onChanged: controller.changeSenha,
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
            BudgetTextFormField(
              label: 'Confirmar Senha',
              onChanged: controller.changeConfirmaSenha,
              validator: (String valor) {
                if (valor.isNotEmpty) {
                  if (valor != controller.senha) {
                    return 'As senhas não são iguais';
                  }
                } else {
                  return 'Confirmar Senha Obrigatória';
                }

                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            BudgetButton(
              label: 'Salvar',
              onPressed: () => controller.salvarUsuario(),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
