import 'package:justmusic/model/Artist.dart';
import 'package:justmusic/model/Music.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';

Future<void> main() async {
  MusicViewModel musicVM = new MusicViewModel();
  Music m = await musicVM.getMusic('295SxdR1DqunCNwd0U767w');

  print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
  print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}");
  for (Artist a in m.artists) {
    print("id : ${a.id}, name : ${a.name}");
  }

  print('\nMusics :');

  List<Music> musics = await musicVM.getMusicsWithName('Shavkat');
  for (Music m in musics) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nMusics With Artist:');

  List<Music> musics2 = await musicVM.getMusicsWithArtistName('jul');
  for (Music m in musics2) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

  print('\nArtist with Name:');

  Artist a = await musicVM.getArtistWithName('jul');
  print("id : ${a.id}, name : ${a.name}, image : ${a.image}");

  print('\nArtists with Name:');

  List<Artist> artists = await musicVM.getArtistsWithName('jul');
  for (Artist a in artists) {
    print("id : ${a.id}, name : ${a.name}, image : ${a.image}");
  }

  print('\nTop Musics :');

  List<Music> topMusics = await musicVM.getTopMusicsWithArtistId('3NH8t45zOTqzlZgBvZRjvB');
  for (Music m in topMusics) {
    print("id : ${m.id.toString()}, cover : ${m.cover}, title : ${m.title}");
    print("date : ${m.date.toString()}, preview : ${m.previewUrl}, duration : ${m.duration}");
    for (Artist a in m.artists) {
      print("id : ${a.id}, name : ${a.name}");
    }
  }

}
