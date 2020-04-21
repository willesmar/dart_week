import 'package:budget_api/controllers/login/login_controller.dart';
import 'package:budget_api/controllers/usuario/usuario_controller.dart';
import 'package:budget_api/budget_api.dart';

class UsuariosRouter {

  static void configurar(Router router, ManagedContext context) {
    router
      .route('/login')
      .link(() => LoginController(context));

    router
      .route('/usuario')
      .link(() => UsuarioController(context));
  }
}
