import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/widgets/text_form_widget.dart';
import 'package:portifolio/src/features/auth/bloc/auth_bloc.dart';

import 'package:portifolio/src/features/auth/bloc/states/auth_state.dart';
import 'package:portifolio/src/features/home/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, this.transitionAnimation});
  final Animation? transitionAnimation;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, AuthState state) async {
            if (state is ErrorAuthState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(state.errorMessage),
                ),
              );
              if (state is LoggedState) {
                if (mounted) {
                  await Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                }
              }
            }
          },
          builder: (context, state) => switch (state) {
                UnloggedState() => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormWidget(
                            labelText: 'Email',
                            textEditingController: _emailController),
                        const SizedBox(height: 20),
                        TextFormWidget(
                            labelText: 'Senha',
                            textEditingController: _passwordController),
                        const SizedBox(height: 20),
                        widget.transitionAnimation != null
                            ? AnimatedBuilder(
                                animation: widget.transitionAnimation!,
                                builder: (context, child) => SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.2,
                                  height: 60,
                                  child: Transform.scale(
                                    origin: Offset.zero,
                                    scale: widget.transitionAnimation?.value,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _authBloc.requestLogin(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                      },
                                      child: state.isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Text('Login'),
                                    ),
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  _authBloc.requestLogin(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                },
                                child: state.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text('Login'),
                              ),
                      ],
                    ),
                  ),
                AuthState() => const Offstage(),
              }),
    );
  }
}
