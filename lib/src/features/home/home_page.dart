import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/core/layout/mobile/mobile_layout.dart';
import 'package:portifolio/src/core/layout/responsive_layout.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/home_bloc.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/home/views/initial_home_view.dart';
import 'package:portifolio/src/features/home/views/projects_view.dart';
import 'package:portifolio/src/features/home/views/training_view.dart';
import 'package:portifolio/src/features/projects/project_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(iProjectService: ProjectService()),
      child: Builder(builder: (context) {
        return ResponsiveLayout(
          mobile: const MobileLayout(),
          desktop: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent, actions: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: TextButton(
                      onHover: (value) {
                        return value
                            ? context.read<HomeBloc>().add(
                                  ChangeColorEvent(
                                    value ? Colors.amberAccent : Colors.white70,
                                    title: 'Início',
                                  ),
                                )
                            : null;
                      },
                      onPressed: () => context
                          .read<HomeBloc>()
                          .add(ChangeView(view: HomeView.initial)),
                      child: const Text('Início')),
                ),
                duration: const Duration(seconds: 1),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: TextButton(
                    onHover: (value) => value
                        ? context.read<HomeBloc>().add(ChangeColorEvent(
                            value ? Colors.purpleAccent : Colors.white70,
                            title: 'Projetos'))
                        : null,
                    onPressed: () => context.read<HomeBloc>().add(
                          ChangeView(view: HomeView.projects),
                        ),
                    child: const Text('Projetos'),
                  ),
                ),
                duration: const Duration(milliseconds: 1500),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: TextButton(
                      onHover: (value) => value
                          ? context.read<HomeBloc>().add(ChangeColorEvent(
                              value ? Colors.redAccent : Colors.white70,
                              title: 'Formação'))
                          : null,
                      onPressed: () => context
                          .read<HomeBloc>()
                          .add(ChangeView(view: HomeView.training)),
                      child: const Text('Formação')),
                ),
                duration: const Duration(milliseconds: 1800),
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.easeInOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: TextButton(
                    onHover: (value) => value
                        ? context.read<HomeBloc>().add(ChangeColorEvent(
                            value ? Colors.greenAccent : Colors.white70,
                            title: 'Contato'))
                        : null,
                    onPressed: () {},
                    child: const Text('Contato'),
                  ),
                ),
                duration: const Duration(milliseconds: 2000),
              ),
            ]),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return switch (state) {
                  InitialHomeState() => InitialHomeView(
                      endColor: state.endColor,
                      title: state.title,
                    ),
                  TrainingHomeState() => const TrainingView(),
                  ProjectsHomeState() => ProjectsView(projects: state.projects),
                  HomeState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                };
              },
            ),
          ),
        );
      }),
    );
  }
}
