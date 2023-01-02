/// Letter class used for containing a corresponding letter and its pronunciation
/// audio file
class Letter {
  Letter({
    this.character, this.audioPath
  });

  String? character;
  String? audioPath;

  @override
  String toString() => character ?? '';
}