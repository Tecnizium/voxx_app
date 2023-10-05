import 'dart:convert';

import 'package:commons/data/data.dart';
import 'package:commons_dependencies/commons_dependencies.dart';

class CacheProvider {
  Future<SharedPreferences> get prefs async => await SharedPreferences.getInstance();

  Future<void> clear() async => (await prefs).clear();
  Future<String> get jwtToken async => (await prefs).getString('jwtToken') ?? '';
  Future<void> setJwtToken(String value) async => (await prefs).setString('jwtToken', value);

  Future<UserModel> get user async => UserModel.fromMap(jsonDecode((await prefs).getString('user') ?? '{}'));
  Future<void> setUser(UserModel value) async => (await prefs).setString('user', jsonEncode(value.toJson()));

  Future<String> get campaignId async => (await prefs).getString('campaignId') ?? '';
  Future<void> setCampaignId(String value) async => (await prefs).setString('campaignId', value);

}