import 'package:justmusic/model/Artist.dart';
import 'package:justmusic/model/Music.dart';
import 'package:justmusic/view_model/MusicViewModel.dart';

Future<void> main() async {
  MusicViewModel musicVM = new MusicViewModel();
  Music m = await musicVM.getMusic('295SxdR1DqunCNwd0U767w');
  print("id :" + m.id.toString() + " cover :" + m.cover + " title :" + m.title);
  print(m.date.toString() + " " + m.previewUrl);
  for (Artist a in m.artists) {
    print(a.id + ":" + a.name);
  }

  print('\nMusics :');

  List<Music> musics = await musicVM.getMusicsWithName('Onizuka');
  for (Music m in musics) {
    print("id :" + m.id.toString() + " cover :" + m.cover + " title :" + m.title);
    print(m.date.toString() + " " + m.previewUrl);
    for (Artist a in m.artists) {
      print(a.id + ":" + a.name);
    }
  }

  print('\nMusics With Artist:');

  List<Music> musics2 = await musicVM.getMusicsWithArtistName('PNL');
  for (Music m in musics2) {
    print("id :" + m.id.toString() + " cover :" + m.cover + " title :" + m.title);
    print(m.date.toString() + " " + m.previewUrl);
    for (Artist a in m.artists) {
      print(a.id + ":" + a.name);
    }
  }
}
