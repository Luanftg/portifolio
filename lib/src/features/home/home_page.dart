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
              TextButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(ChangeView(view: HomeView.initial)),
                  child: const Text('Início')),
              TextButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(ChangeView(view: HomeView.projects)),
                  child: const Text('Projetos')),
              TextButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(ChangeView(view: HomeView.training)),
                  child: const Text('Formação')),
              TextButton(onPressed: () {}, child: const Text('Contato')),
            ]),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return switch (state) {
                  InitialHomeState() => const InitialHomeView(),
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
