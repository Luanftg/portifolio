import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portifolio/src/features/home/bloc/event/home_event.dart';
import 'package:portifolio/src/features/home/bloc/home_bloc.dart';
import 'package:portifolio/src/features/home/bloc/state/home_state.dart';
import 'package:portifolio/src/features/home/views/initial_home_view.dart';
import 'package:portifolio/src/features/home/views/mobile_projects_view.dart';
import 'package:portifolio/src/features/home/views/mobile_training_view.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              TextButton(
                onHover: (value) {
                  return value
                      ? context.read<HomeBloc>().add(
                            ChangeColorEvent(
                              Colors.amberAccent,
                              title: 'Início',
                            ),
                          )
                      : null;
                },
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.initial),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Início'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.purpleAccent,
                              title: 'Projetos'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.projects),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Projetos'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.redAccent, title: 'Formação'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.training),
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Formação'),
              ),
              TextButton(
                onHover: (value) => value
                    ? context.read<HomeBloc>().add(
                          ChangeColorEvent(Colors.greenAccent,
                              title: value ? 'Contato' : 'Luan Fonseca'),
                        )
                    : null,
                onPressed: () {
                  context.read<HomeBloc>().add(
                        ChangeView(view: HomeView.contacts),
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Contato'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            InitialHomeState() => InitialHomeView(
                endColor: state.endColor,
                title: state.title,
              ),
            TrainingHomeState() => const MobileTrainingView(),
            ProjectsHomeState() => MobileProjectsView(projects: state.projects),
            HomeState() => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        },
      ),
    );
  }
}
