import 'package:budget_api/config/jwt_authentication.dart';
import 'package:budget_api/controllers/movimentacoes/movimentacoes_controller.dart';
import 'package:budget_api/budget_api.dart';

class MovimentacoesRouter {
  static void configurar(Router router, ManagedContext context) {
    router
      .route('/movimentacoes/:anoMes')
      .link(() => JwtAuthentication(context))
      .link(() => MovimentacoesController(context));

    router
      .route('movimentacoes/total/:totalAnoMes')
      .link(() => JwtAuthentication(context))
      .link(() => MovimentacoesController(context));

    router
      .route('movimentacoes/')
      .link(() => JwtAuthentication(context))
      .link(() => MovimentacoesController(context));
  }
}
