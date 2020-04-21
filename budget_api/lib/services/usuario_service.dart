import 'dart:convert';

import 'package:budget_api/controllers/login/dto/login_request.dart';
import 'package:budget_api/controllers/usuario/dto/cadastrar_usuario_request.dart';
import 'package:budget_api/model/usuario_model.dart';
import 'package:budget_api/repository/usuario_repository.dart';
import 'package:budget_api/utils/criptografia_util.dart';
import 'package:budget_api/utils/jwt_utils.dart';
import 'package:budget_api/budget_api.dart';

class UsuarioService {

  UsuarioService(this.context) : usuarioRepository = UsuarioRepository(context);

  final ManagedContext context;
  final UsuarioRepository usuarioRepository;

  Future<String> login(LoginRequest request) async {
    final String login = request.login;
    final String senha = request.senha;
    final String senhaCriptografada = CriptografiaUtils.criptografarSenha(senha);

    final usuario = await usuarioRepository.recuperarUsuarioPorLoginESenha(login, senhaCriptografada);

    if (usuario != null) {
      return JwtUtils.gerarTokenJWT(usuario);
    }

    return null;
  }

  Future<void> salvarUsuario(CadastrarUsuarioRequest request) async {
    await usuarioRepository.salvarUsuario(request);
  }

  Future<UsuarioModel> buscarPorId(int id) async {
    return await usuarioRepository.buscarPorId(id);
  }
}
