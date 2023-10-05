import 'package:commons/commons.dart';
import 'package:commons_dependencies/commons_dependencies.dart';

class HomeApiProvider {
  final Dio dio = Dio();

  Future<Response> updateUser(UserModel user, String jwtToken) async {
    try {
      return await dio.put(
        'https://guardian-gate.kindrock-da55ab0b.eastus.azurecontainerapps.io/User/updateuser',
        data: user.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $jwtToken'
          },
        ),
      );
    }on DioException catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(), statusCode: 500);
    }
  }

  Future<Response> getPollsByCampaignId(String campaignId, String jwtToken) async {
    try {
      return await dio.get(
        'https://campaign-forge.kindrock-da55ab0b.eastus.azurecontainerapps.io/Poll/getpollsbycampaign',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $jwtToken',
            'campaignId': campaignId
          },
        ),
      );
    }on DioException catch (e) {
      return e.response ?? Response(requestOptions: RequestOptions(), statusCode: 500);
    }
  }

Future<Response> sendAnswersPoll(AnswersModel answers, String jwtToken) async{
  try {
    return await dio.post(
      'https://survey-scout.kindrock-da55ab0b.eastus.azurecontainerapps.io/Answers/createAnswers',
      data: answers.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $jwtToken'
        },
      ),
    );
  }on DioException catch (e) {
    return e.response ?? Response(requestOptions: RequestOptions(), statusCode: 500);
  }
}

}