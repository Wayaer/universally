import 'package:path/path.dart' as path;

extension ExtensionPathString on String {
  String get basenameWithoutExtension => path.basenameWithoutExtension(this);

  String get basename => path.basename(this);

  String extension([int level = 1]) => path.extension(this, level);

  List<String> pathSplit() => path.split(this);

  bool equals(String path2) => path.equals(this, path2);

  bool isWithin(String child) => path.isWithin(this, child);

  String relative({String? from}) => path.relative(this, from: from);

  String get withoutExtension => path.withoutExtension(this);

  String setExtension(String extension) => path.setExtension(this, extension);

  Uri get toUri => path.toUri(this);

  int get hash => path.hash(this);

  String get dirname => path.dirname(this);

  String get rootPrefix => path.rootPrefix(this);

  String get canonicalize => path.canonicalize(this);

  String get normalize => path.normalize(this);

  bool get isAbsolute => path.isAbsolute(this);

  bool get isRelative => path.isRelative(this);

  bool get isRootRelative => path.isRootRelative(this);

  String join([
    String? part2,
    String? part3,
    String? part4,
    String? part5,
    String? part6,
    String? part7,
    String? part8,
    String? part9,
    String? part10,
    String? part11,
    String? part12,
    String? part13,
    String? part14,
    String? part15,
    String? part16,
  ]) => path.join(
    this,
    part2,
    part3,
    part4,
    part5,
    part6,
    part7,
    part8,
    part9,
    part10,
    part11,
    part12,
    part13,
    part14,
    part15,
    part16,
  );

  String absolute([
    String? part2,
    String? part3,
    String? part4,
    String? part5,
    String? part6,
    String? part7,
    String? part8,
    String? part9,
    String? part10,
    String? part11,
    String? part12,
    String? part13,
    String? part14,
    String? part15,
  ]) => path.absolute(
    this,
    part2,
    part3,
    part4,
    part5,
    part6,
    part7,
    part8,
    part9,
    part10,
    part11,
    part12,
    part13,
    part14,
    part15,
  );
}

extension ExtensionPathIterableString on Iterable<String> {
  String get joinAll => path.joinAll(this);
}

extension ExtensionPathObject on Object {
  String get prettyUri => path.prettyUri(this);

  String get fromUri => path.fromUri(this);
}
