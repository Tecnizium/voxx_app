import 'package:commons_dependencies/commons_dependencies.dart';

class CoreApiProvider {
  final Dio dio = Dio();

  Future<Response> checkJwtToken(String jwtToken) async {
    try {
      return await dio.get(
        'https://guardian-gate.kindrock-da55ab0b.eastus.azurecontainerapps.io/User/getuser',
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
