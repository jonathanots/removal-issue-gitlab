import 'package:flutter/material.dart';
import 'package:gitlab_management/repositories/gitlab_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = GitLabRepository(token: "<your-access-token>");

  final projectController = TextEditingController();
  final issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Seja bem vinda Letícia ao removedor de Issues do Gitlab",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Para remover uma Issue de um Projeto você deverá fornecer algumas informações:",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[500]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 6),
                  blurRadius: 10,
                  spreadRadius: 7,
                ),
              ],
              color: Colors.grey.shade100,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: projectController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "ID do Projeto",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: issueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "ID da Issue",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await repository.deleteIssue(
                          projectController.text, issueController.text);

                      if (result == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Issue removida com sucesso!"),
                          backgroundColor: Colors.green,
                        ));

                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(result),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500]),
                    child: SizedBox(
                      height: 50,
                      width: 120,
                      child: Row(
                        children: const [
                          Text("Remover Issue"),
                          Icon(Icons.delete)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
