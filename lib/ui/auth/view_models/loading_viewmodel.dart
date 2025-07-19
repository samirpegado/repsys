import 'dart:convert';

import 'package:repsys/app_state/app_state.dart';
import 'package:repsys/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoadingViewModel {
  final AppState appState;
  final supabase = Supabase.instance.client;

  LoadingViewModel({required this.appState});

  Future<void> init() async {
    await appState.carregar(); // carrega SharedPreferences locais
    await carregarUsuario();
  }

  Future<void> carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final session = supabase.auth.currentSession;
    final user = session?.user;

    if (user == null) return;

    final saved = prefs.getString('usuario');
    if (saved != null) {
      final model = UserModel.fromJson(jsonDecode(saved));
      if (model.id == user.id) {
        appState.salvarUsuario(model);
        return;
      }
    }

    final response =
        await supabase.from('users').select().eq('id', user.id).single();
    final usuario = UserModel.fromMap(response);
    await appState.salvarUsuario(usuario);
  }
}
