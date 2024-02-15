import 'package:flutter/material.dart';
import 'package:portifolio/src/features/projects/project_model.dart';

class MobileProjectsView extends StatelessWidget {
  const MobileProjectsView({super.key, required this.projects});
  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Projetos',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
      body: ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: SizedBox(
            child: Card(
              elevation: 5,
              color: Colors.blueGrey.shade800,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      projects[index].imagePath,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 24),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text('Projeto ${projects[index].name}',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Text(
                      projects[index].date,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      projects[index].description,
                      // maxLines: 5,
                      softWrap: true, textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) =>
            const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
        itemCount: projects.length,
      ),
    );
  }
}
