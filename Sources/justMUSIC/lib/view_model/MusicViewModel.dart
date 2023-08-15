import 'dart:convert';

import 'package:justmusic/view_model/TokenSpotify.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import '../model/Artist.dart';
import '../model/Music.dart';
import '../services/MusicService.dart';

class MusicViewModel {
  final String API_URL = "https://api.spotify.com/v1";
  late TokenSpotify _token;
  MusicService _musicService = MusicService();

  MusicViewModel() {
    _token = new TokenSpotify();
  }

  // Methods
  Future<Music> getMusic(String id) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(Uri.parse('$API_URL/tracks/$id'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      return _getMusicFromResponse(responseData);
    } else {
      throw Exception('Error retrieving music information : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Music _getMusicFromResponse(dynamic track) {
    List<Artist> artists = List<Artist>.from(track['artists'].map((artist) {
      return Artist(artist['id'], artist['name'], '');
    }));

    return Music(
        track['id'],
        track['name'],
        track['album']['images'][0]['url'],
        track['preview_url'],
        int.parse(track['album']['release_date'].split('-')[0]),
        track['duration_ms'] / 1000,
        track['explicit'],
        artists);
  }

  Future<List<Music>> getMusicsWithName(String name, {int limit = 20, int offset = 0, String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http
        .get(Uri.parse('$API_URL/search?q=track%3A$name&type=track&market=fr&limit=$limit&offset=$offset'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return List<Music>.from(responseData['tracks']['items'].map((track) {
        return _getMusicFromResponse(track);
      }));
    } else {
      throw Exception('Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getMusicsWithArtistName(String name,
      {int limit = 20, int offset = 0, String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http
        .get(Uri.parse('$API_URL/search?q=artist%3A$name&type=track&market=fr&limit=$limit&offset=$offset'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return List<Music>.from(responseData['tracks']['items'].map((track) {
        return _getMusicFromResponse(track);
      }));
    } else {
      throw Exception('Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<Artist> getArtistWithName(String name, {String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(Uri.parse('$API_URL/search?q=artist%3A$name&type=artist&market=$market'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      List<Artist> artists = List<Artist>.from(responseData['artists']['items'].map((artist) {
        String image = '';
        if (!artist['images'].isEmpty) {
          image = artist['images'][0]['url'];
        }
        return Artist(artist['id'], artist['name'], image);
      }));

      for (Artist a in artists) {
        if (a.name?.toLowerCase() == name.toLowerCase()) {
          return a;
        }
      }

      throw Exception('Artist not found : ${name}');
    } else {
      throw Exception('Error retrieving artist information : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Artist>> getArtistsWithName(String name, {int limit = 20, int offset = 0, String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(
        Uri.parse('$API_URL/search?q=artist%3A$name&type=artist&market=$market&limit=$limit&offset=$offset'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      List<Artist> artists = List<Artist>.from(responseData['artists']['items'].map((artist) {
        String image = '';
        if (!artist['images'].isEmpty) {
          image = artist['images'][0]['url'];
        }
        return Artist(artist['id'], artist['name'], image);
      }));

      return artists;
    } else {
      throw Exception('Error while retrieving artist : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getTopMusicsWithArtistId(String id, {String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(Uri.parse('$API_URL/artists/$id/top-tracks?market=$market'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return List<Music>.from(responseData['tracks'].map((track) {
        return _getMusicFromResponse(track);
      }));
    } else {
      throw Exception('Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getMusicsWithPlaylistId(String id, {String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    var response = await http.get(Uri.parse('$API_URL/playlists/$id?market=$market'), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      List<Music> musics = [];

      List<dynamic> tracks = responseData['tracks']['items'];
      for (var track in tracks) {
        musics.add(_getMusicFromResponse(track['track']));
      }

      return musics;
    } else {
      throw Exception('Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getMusicsWithIds(List<String> ids, {String market = "FR"}) async {
    var accessToken = await _token.getAccessToken();
    String url = API_URL + '/tracks?market=$market&ids=';

    if (ids.length == 0) return [];

    url += ids.join('%2C');

    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $accessToken',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return List<Music>.from(responseData['tracks'].map((track) {
        return _getMusicFromResponse(track);
      }));
    } else {
      throw Exception('Error while retrieving music : ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<List<Music>> getMusicsWithNameOrArtistName(String name,
      {int limit = 20, int offset = 0, String market = "FR"}) async {
    try {
      List<Music> musics = [];
      Artist artist = await getArtistWithName(name, market: market);
      musics.addAll(await getTopMusicsWithArtistId(artist.id));
      musics.addAll(await getMusicsWithName(name, limit: limit, offset: offset, market: market));
      return musics;
    } catch (e) {
      return await getMusicsWithName(name, limit: limit, offset: offset, market: market);
    }
  }

  Future<List<Music>> getFavoriteMusicsByUserId(String id) async {
    try {
      var idMusics = await _musicService.getFavoriteMusicsByUserId(id);
      return await getMusicsWithIds(idMusics);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> addOrDeleteFavoriteMusic(String id) async {
    try {
      return await _musicService.addOrDeleteFavoriteMusic(id);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Tuple2<int, Music>>> getHistoryCapsulesMonthWhitIdUser(String idUser, int month, int year) async {
    try {
      List<Tuple2<int, Music>> capsules = [];
      var capsulesData = await _musicService.getHistoryCapsulesMonthWhitIdUser(idUser, month, year);

      var musics = await getMusicsWithIds(capsulesData.map((capsule) => capsule.item2).toList());

      for (var capsule in capsulesData) {
        var music = musics.firstWhere((music) => music.id == capsule.item2);
        print(capsule.item1);
        capsules.add(Tuple2(capsule.item1, music));
      }
      return capsules;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
