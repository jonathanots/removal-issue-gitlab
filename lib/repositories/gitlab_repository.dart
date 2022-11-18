import 'package:dio/dio.dart';

class GitLabRepository {
  late final Dio _client;

  GitLabRepository(
      {required String token, String baseUrl = "https://gitlab.com/api/v4"}) {
    _client = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {"PRIVATE-TOKEN": token},
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  Future<String?> deleteIssue(String projectId, String issueId) async {
    try {
      final result =
          await _client.delete("/projects/$projectId/issues/$issueId");

      if (result.statusCode == 401) {
        return "Ação não autorizada, por favor, verifique o token da sua conta ou consulte o Alt L";
      }

      if (result.statusCode == 404) {
        return "Issue não encontrada";
      }

      if (result.statusCode! >= 400) {
        return "Ooops... Algo errado não está certo, por favor, chame o Jonathan";
      }
    } catch (e) {
      return "Algo inesperado aconteceu, por favor, chame o Jonathan.";
    }

    return null;
  }
}
