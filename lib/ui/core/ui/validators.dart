import 'package:form_validator/form_validator.dart';

class AppValidators {
  static String? Function(String?) email() {
    return ValidationBuilder(
      requiredMessage: 'Campo obrigatório!',
    ).required().email('E-mail inválido').build();
  }

  static String? Function(String?) senha() {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Informe a senha')
        .minLength(6, 'Mínimo 6 caracteres')
        .build();
  }

  static String? Function(String?) nome({String label = 'Nome'}) {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Informe o $label')
        .minLength(3, 'Min. 3 caracteres')
        .maxLength(80, 'Máx. 80 caracteres')
        .build();
  }
   static String? Function(String?) celular({String label = 'Celular'}) {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Informe o $label')
        .minLength(14, 'Número inválido')
        .build();
  }

  static String? Function(String?) numero({String label = 'Número'}) {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Informe o $label')
        .regExp(RegExp(r'^\d+$'), '$label deve conter apenas números')
        .build();
  }

  static String? Function(String?) cpf() {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Informe o CPF')
        .regExp(RegExp(r'^\d{11}$'), 'CPF inválido')
        .build();
  }

  static String? Function(String?) confirmarSenha(String senha) {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
        .required('Confirme a senha')
        .add((val) => val == senha ? null : 'As senhas não coincidem')
        .build();
  }

  static String? Function(String?) data({String label = 'Data'}) {
    return ValidationBuilder()
       // .required('Informe a $label')
        .add((val) {
          if (val == null || val.isEmpty) return null;
          
          // Verifica formato dd/mm/yyyy
          final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
          if (!regex.hasMatch(val)) {
            return 'Formato inválido. Use dd/mm/yyyy';
          }
          
          // Extrai dia, mês e ano
          final parts = val.split('/');
          final dia = int.tryParse(parts[0]);
          final mes = int.tryParse(parts[1]);
          final ano = int.tryParse(parts[2]);
          
          if (dia == null || mes == null || ano == null) {
            return 'Data inválida';
          }
          
          // Validação básica de limites
          if (dia < 1 || dia > 31 || mes < 1 || mes > 12 || ano < 1900 || ano > 2100) {
            return 'Data inválida';
          }
          
          // Validação mais precisa usando DateTime
          try {
            final data = DateTime(ano, mes, dia);
            // Verifica se a data criada corresponde aos valores informados
            // (para evitar datas como 31/02)
            if (data.day != dia || data.month != mes || data.year != ano) {
              return 'Data inválida';
            }
            return null;
          } catch (e) {
            return 'Data inválida';
          }
        })
        .build();
  }

  static String? Function(String?) emailOpcional() {
    return ValidationBuilder()
        .add((val) {
          if (val == null || val.isEmpty) return null;
          return ValidationBuilder(requiredMessage: 'Campo obrigatório!',)
              .email('E-mail inválido')
              .build()(val);
        })
        .build();
  }

  static String? Function(String?) dataOpcional({String label = 'Data'}) {
    return ValidationBuilder(requiredMessage: 'Campo obrigatório!')
        .add((val) {
          if (val == null || val.isEmpty) return null;
          return data(label: label)(val);
        })
        .build();
  }

  
}
