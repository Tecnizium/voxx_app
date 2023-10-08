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

  Future<List<AnswersModel>> get answers async => (jsonDecode((await prefs).getString('answers') ?? '[]') as List).map((e) => AnswersModel.fromMap(e)).toList();
  Future<void> setAnswers(List<AnswersModel> value) async => (await prefs).setString('answers', jsonEncode(value.map((e) => e.toJson()).toList()));
  Future<void> clearAnswers() async => (await prefs).remove('answers');

  Future<List<PollModel>> get polls async => (jsonDecode((await prefs).getString('polls') ?? '[]') as List).map((e) => PollModel.fromMap(e)).toList();
  Future<void> setPolls(List<PollModel> value) async => (await prefs).setString('polls', jsonEncode(value.map((e) => e.toJson()).toList()));
  Future<void> clearPolls() async => (await prefs).remove('polls');

  Future<DateTime> get lastUpdate async => DateTime.parse((await prefs).getString('lastUpdate') ?? DateTime.now().toIso8601String());
  Future<void> setLastUpdate(DateTime value) async => (await prefs).setString('lastUpdate', value.toIso8601String());


}