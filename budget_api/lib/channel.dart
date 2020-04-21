import 'budget_api.dart';
import 'package:budget_api/model/usuario_model.dart';
import 'package:budget_api/model/categoria_model.dart';
import 'package:budget_api/model/movimentacao_model.dart';
import 'package:budget_api/routers/usuarios_router.dart';
import 'package:budget_api/routers/categoria_router.dart';
import 'package:budget_api/routers/movimentacoes_router.dart';

class BudgetApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = BudgetApiConfiguration(options.configurationFilePath);
    context = contextWithConnectionInfo(config.database);
  }

  @override
  Controller get entryPoint {
    final router = Router();
    UsuariosRouter.configurar(router, context);
    CategoriaRouter.configurar(router, context);
    MovimentacoesRouter.configurar(router, context);
    return router;
  }

  ManagedContext contextWithConnectionInfo(DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
      connectionInfo.username,
      connectionInfo.password,
      connectionInfo.host,
      connectionInfo.port,
      connectionInfo.databaseName,
    );

    return ManagedContext(dataModel, psc);
  }
}

class BudgetApiConfiguration extends Configuration {
  BudgetApiConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConfiguration database;
}
