import 'package:faker/faker.dart';

class WritingApiService {
  Future<Response> generatePromptText(List<String> topics) async {
    // TODO: dummy data
    await Future.delayed(const Duration(seconds: 2));
    return Response(faker.lorem.sentences(3).join("\n"));
  }
}

class Response {
  final String promptText;

  const Response(this.promptText);
}
