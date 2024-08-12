

part of'../register_page.dart';

class _FormRegister extends StatefulWidget {

  const _FormRegister({Key? key }) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<_FormRegister> {
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  
 @override
  void dispose() {
   _loginEC.dispose();
   _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<RegisterController>();

    return Form(
      key: _formKey,
      child:Column(
        children: [
          CuidaperTextFormField(
            label: 'Login',
            controller:_loginEC ,
            validator: Validatorless.multiple([
               Validatorless.required("campo obrigatorio"),
              Validatorless.email("login precisa preenchido corretamente")
            ]),
            ),
          const SizedBox(
             height: 10,
          ),
          CuidaperTextFormField(
            label: 'Senha',
            obscureText: true,
            controller: _passwordEC,
            validator: Validatorless.multiple([
                 Validatorless.required("campo obrigatorio"),
                Validatorless.min(6, 'preencha no minino 6 caracteres')
             ]),
            ),
          const SizedBox(height: 10,),
          CuidaperTextFormField(
            label: 'Confirme Password',
            obscureText: true,
            validator: Validatorless.multiple([
              Validatorless.required("campo obrigatorio"),
              Validatorless.compare(_passwordEC, "as senhas não são iguais")
            ]
            ),
            ),
          const SizedBox(height: 20,),
           CuidapetDefaultButton(
            height: 50.h.toDouble(),
            onPressed: () {
                  final isValid = _formKey.currentState?.validate() ?? false;
                  FocusScope.of(context).unfocus();
                  if (isValid) {
                    controller.register(login: _loginEC.text,password: _passwordEC.text);
                  }
            }, 
            label: 'Cadastrar'
            )
        ],
      ) 
      );
  }
}