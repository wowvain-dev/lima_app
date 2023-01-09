enum Type {
  vowel,
  consonant
}

/// Letter class used for containing a corresponding letter and its pronunciation
/// audio file
class Letter {
  Letter({
    this.character, this.audioPath
  });

  String? character;
  String? audioPath;

  Type get type {
    if (['a', 'e', 'i', 'o', 'u', 'î', 'ă', 'â'].contains(character)) {
      return Type.vowel;
    }
    return Type.consonant;
  }

  @override
  String toString() => character ?? '';
}