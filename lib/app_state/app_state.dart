import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repsys/domain/models/despesa.dart';
import 'package:repsys/domain/models/register_data_model.dart';
import 'package:repsys/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  UserModel? _usuario;
  RegisterDataModel? _registerData;
  String? savedEmail;
  String? savedPassword;

  XFile? _profilePic;
  int pageViewIndex = 0;

  UserModel? get usuario => _usuario;
  RegisterDataModel? get registerData => _registerData;

  XFile? get profilePic => _profilePic;
  DespesaModel? despesaSelecionada;

  Future<void> salvarUsuario(UserModel usuario) async {
    _usuario = usuario;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', jsonEncode(usuario.toJson()));
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

  Future<void> atualizarProfilePicUrl(String? novaUrl) async {
    if (_usuario != null && novaUrl != null) {
      _usuario = _usuario!.copyWith(profilePic: novaUrl);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('usuario', jsonEncode(_usuario!.toJson()));
      notifyListeners();
    }
  }

  Future<void> atualizarUsuario(
      {required String nome, required String celular}) async {
    if (_usuario == null) return;

    _usuario = _usuario!.copyWith(
      nome: nome,
      celular: celular,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', jsonEncode(_usuario!.toJson()));
    notifyListeners();
  }

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final usuarioJson = prefs.getString('usuario');
    final getSavedEmail = prefs.getString('savedEmail');
    final getSavedPassword = prefs.getString('savedPassword');  

    if (getSavedEmail != null && getSavedPassword != null) {
      savedEmail = getSavedEmail;
      savedPassword = getSavedPassword;
    }

    if (usuarioJson != null) {
      _usuario = UserModel.fromJson(jsonDecode(usuarioJson));
    }

    notifyListeners();
  }

  /// atualizar index do PageView
  void setPageViewIndex(int i) {
    pageViewIndex = i;
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
}
