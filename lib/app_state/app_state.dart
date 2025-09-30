import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repsys/domain/models/catalogo_filtro_model.dart';
import 'package:repsys/domain/models/despesa.dart';
import 'package:repsys/domain/models/register_data_model.dart';
import 'package:repsys/domain/models/user_empresa_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  RegisterDataModel? _registerData;
  String? savedEmail;
  String? savedPassword;

  XFile? _profilePic;
  int pageViewIndex = 0;
  int menuIndex = 0;
  RegisterDataModel? get registerData => _registerData;

  XFile? get profilePic => _profilePic;
  DespesaModel? despesaSelecionada;

  UserModel? _usuario;
  EmpresaModel? _empresa;

  UserModel? get usuario => _usuario;
  EmpresaModel? get empresa => _empresa;

  bool get isLoggedIn => _usuario != null;

  CatalogoFiltroModel? _catalogoFiltro;

  CatalogoFiltroModel? get catalogoFiltro => _catalogoFiltro;

  Future<void> updateCatalogoFiltro({
    Object? busca = CatalogoFiltroModel.kUnset,
    Object? tipo = CatalogoFiltroModel.kUnset,
    Object? marca = CatalogoFiltroModel.kUnset,
    bool replaceAll = false, // se true, zera os não passados
  }) async {
    final current = _catalogoFiltro ?? const CatalogoFiltroModel();

    _catalogoFiltro = replaceAll
        ? CatalogoFiltroModel(
            busca: identical(busca, CatalogoFiltroModel.kUnset)
                ? null
                : busca as String?,
            tipo: identical(tipo, CatalogoFiltroModel.kUnset)
                ? null
                : tipo as String?,
            marca: identical(marca, CatalogoFiltroModel.kUnset)
                ? null
                : marca as String?,
          )
        : current.copyWith(busca: busca, tipo: tipo, marca: marca);

    notifyListeners();
  }

  /// Salva e atualiza estado
  Future<void> salvarUsuarioEmpresa({
    required UserModel usuario,
    EmpresaModel? empresa,
  }) async {
    _usuario = usuario;
    _empresa = empresa;
    await usuario.saveToPrefs();
    if (empresa != null) {
      await empresa.saveToPrefs();
    } else {
      await EmpresaModel.clearFromPrefs();
    }
    notifyListeners();
  }

  /// Limpa tudo ao fazer logout/erro
  Future<void> limparUsuarioEmpresa() async {
    _usuario = null;
    _empresa = null;
    await UserModel.clearFromPrefs();
    await EmpresaModel.clearFromPrefs();
    notifyListeners();
  }

  /// Atualizações locais convenientes (ex.: editar perfil)
  Future<void> atualizarUsuario({
    String? nome,
    String? celular,
  }) async {
    if (_usuario == null) return;
    _usuario = _usuario!.copyWith(
      nome: nome ?? _usuario!.nome,
      celular: celular ?? _usuario!.celular,
    );
    await _usuario!.saveToPrefs();
    notifyListeners();
  }

  Future<void> saveLoginData(String email, String password) async {
    savedEmail = email;
    savedPassword = password;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedEmail', email);
    await prefs.setString('savedPassword', password);
    notifyListeners();
  }

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    // carrega o email e senha do shared preferences
    final getMenuIndex = prefs.getInt('menuIndex');
    final getSavedEmail = prefs.getString('savedEmail');
    final getSavedPassword = prefs.getString('savedPassword');

    //carrega os dados da empresa e os dados do usuário do shared preferences
    _usuario = await UserModel.loadFromPrefs();
    _empresa = await EmpresaModel.loadFromPrefs();

    if (getSavedEmail != null && getSavedPassword != null) {
      savedEmail = getSavedEmail;
      savedPassword = getSavedPassword;
    }

    if(getMenuIndex != null){
      menuIndex = getMenuIndex;
    }

    notifyListeners();
  }

  /// atualizar index do PageView
  void setPageViewIndex(int i) {
    pageViewIndex = i;
    notifyListeners();
  }

  /// atualizar index do PageView
  void setMenuIndex(int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('menuIndex', i);    
    menuIndex = i;
    notifyListeners();
  }

  void backPageView() {
    if (pageViewIndex > 0) {
      pageViewIndex--;
      notifyListeners();
    }
  }

  /// salvar os dados do registro
  void salvarStep1({
    required String nome,
    required String email,
    required String celular,
    required String cpf,
    required String senha,
  }) {
    _registerData ??= RegisterDataModel();
    _registerData!
      ..nome = nome
      ..email = email
      ..celular = celular
      ..cpf = cpf
      ..senha = senha;
    notifyListeners();
  }

  void salvarStep2({
    required String nomeFantasia,
    String? razaoSocial,
    String? cnpj,
    String? site,
    required String empresaEmail,
    required String telefone,
  }) {
    _registerData ??= RegisterDataModel();
    _registerData!
      ..nomeFantasia = nomeFantasia
      ..razaoSocial = razaoSocial
      ..cnpj = cnpj
      ..site = site
      ..empresaEmail = empresaEmail
      ..telefone = telefone;
    notifyListeners();
  }

  void salvarStep3({
    required String cep,
    required String endereco,
    required String numero,
    required String bairro,
    required String cidade,
    required String uf,
    String? complemento,
  }) {
    _registerData ??= RegisterDataModel();
    _registerData!
      ..cep = cep
      ..endereco = endereco
      ..numero = numero
      ..bairro = bairro
      ..cidade = cidade
      ..uf = uf
      ..complemento = complemento;
    notifyListeners();
  }

  void limparDadosRegistro() {
    pageViewIndex = 0;
    _registerData = null;
  }
}
