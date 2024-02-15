import 'package:portifolio/src/features/projects/project_model.dart';

abstract class IProjectService {
  Future<List<ProjectModel>> getAll();
}

class ProjectService implements IProjectService {
  @override
  Future<List<ProjectModel>> getAll() async {
    return [
      ProjectModel(
        name: 'MVS Rastreamento',
        date: '2023 - 2024',
        description:
            'Aplicativo para Rastreamento veicular, desenvolvido em flutter, publicado na Google Play Store',
        imagePath: 'assets/projects/mvs.png',
      ),
      ProjectModel(
        name: 'Finanças Pessoais',
        date: '2022',
        description:
            'Aplicativo para Gerenciamento de Finanças pessoais, desenvolvido em Flutter, no projeto de finalização do curso de Desenvolvimento Mobile com FLutter da Proz Educação. Possui integração com o Firebase nos serviços de Autenticação e Armazenamento com CloudFireStore.',
        imagePath: 'assets/projects/finanças_pessoais.png',
      ),
      ProjectModel(
        name: 'Kadosh',
        date: '2023',
        description:
            'Aplicativo para Agendamento de datas e horários para serviços de barbearia, desenvolvido em FLutter, junto a DevsFree - comunidade de desenvolvimento.',
        imagePath: 'assets/projects/kadosh.png',
      ),
    ];
  }
}
