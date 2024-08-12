
part of '../login_page.dart'; 
class _LoginForm extends StatefulWidget {

  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<LoginController>();

    return   Form(
      key: _formKey,
      child: Column(
        children: [
          CuidaperTextFormField(
            label: 'Login',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("Campo Obrigatório"),
              Validatorless.email("email incorreto")
            ]),
            ),
          const SizedBox(
             height: 20,
          ),
          CuidaperTextFormField(
            label: 'Senha',
            controller: _passwordEC,
            validator: Validatorless.multiple([
            Validatorless.required("Campo Obrigatório"),
            Validatorless.min(6, "Senha precisa conter pelo menos 6 caracteres")
            ]),
            obscureText: true,
            ),
          const SizedBox( height: 20),
          CuidapetDefaultButton(
              onPressed: (){
                final isValid = _formKey.currentState?.validate() ?? false;
                FocusScope.of(context).unfocus();
                if (isValid) {
                  
                 controller.login(_loginEC.text, _passwordEC.text);
                }
              }, 
              label: "Entrar",
              height: 50.h.toDouble(),
              )
        ],
        )
      );
  }
}

