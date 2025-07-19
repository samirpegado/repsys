import 'package:repsys/app_state/app_state.dart';
import 'package:repsys/data/repositories/endereco_repository.dart';
import 'package:repsys/data/services/auth_service.dart';

class SignUpViewModel {
  final AuthService authService;
  final AppState appState;
  final EnderecoRepository enderecoRepository;

  SignUpViewModel({required this.authService, required this.appState, required this.enderecoRepository});

  Future<Map<String, dynamic>?> buscarEndereco(String cep) {
    return enderecoRepository.buscarEnderecoPorCep(cep);
  }
}
