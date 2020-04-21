import 'package:budget_api/controllers/usuario/dto/cadastrar_usuario_request.dart';
import 'package:budget_api/services/usuario_service.dart';
import 'package:budget_api/budget_api.dart';

class UsuarioController extends ResourceController {

  UsuarioController(this.context) : usuarioService = UsuarioService(context);

  final ManagedContext context;
  final UsuarioService usuarioService;

  @Operation.post()
  Future<Response> salvar(@Bind.body() CadastrarUsuarioRequest request) async {

    final validate = request.validate();

    if (validate.isNotEmpty) {
      return Response.badRequest(body: validate);
    }

    try {
      await usuarioService.salvarUsuario(request);
      return Response.ok({'message': 'Usuário cadastrado com sucesso'});
    } catch(e) {
      print(e);
      return Response.serverError(body: {'message': 'Erro ao salvar usuário', 'exception': e.toString()});
    }
  }
}
