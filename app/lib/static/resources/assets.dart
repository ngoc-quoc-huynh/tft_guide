import 'package:equatable/equatable.dart';

// TODO: Use extension type
final class Asset extends Equatable {
  const Asset(this.path);

  final String path;

  @override
  List<Object?> get props => [path];
}

final class Assets {
  const Assets._();

  static const iron1 = Asset('assets/divisions/iron/1.webp');
  static const iron2 = Asset('assets/divisions/iron/2.webp');
  static const iron3 = Asset('assets/divisions/iron/3.webp');
  static const iron4 = Asset('assets/divisions/iron/4.webp');
  static const bronze1 = Asset('assets/divisions/bronze/1.webp');
  static const bronze2 = Asset('assets/divisions/bronze/2.webp');
  static const bronze3 = Asset('assets/divisions/bronze/3.webp');
  static const bronze4 = Asset('assets/divisions/bronze/4.webp');
  static const silver1 = Asset('assets/divisions/silver/1.webp');
  static const silver2 = Asset('assets/divisions/silver/2.webp');
  static const silver3 = Asset('assets/divisions/silver/3.webp');
  static const silver4 = Asset('assets/divisions/silver/4.webp');
  static const gold1 = Asset('assets/divisions/gold/1.webp');
  static const gold2 = Asset('assets/divisions/gold/2.webp');
  static const gold3 = Asset('assets/divisions/gold/3.webp');
  static const gold4 = Asset('assets/divisions/gold/4.webp');
  static const platinum1 = Asset('assets/divisions/platinum/1.webp');
  static const platinum2 = Asset('assets/divisions/platinum/2.webp');
  static const platinum3 = Asset('assets/divisions/platinum/3.webp');
  static const platinum4 = Asset('assets/divisions/platinum/4.webp');
  static const emerald1 = Asset('assets/divisions/emerald/1.webp');
  static const emerald2 = Asset('assets/divisions/emerald/2.webp');
  static const emerald3 = Asset('assets/divisions/emerald/3.webp');
  static const emerald4 = Asset('assets/divisions/emerald/4.webp');
  static const diamond1 = Asset('assets/divisions/diamond/1.webp');
  static const diamond2 = Asset('assets/divisions/diamond/2.webp');
  static const diamond3 = Asset('assets/divisions/diamond/3.webp');
  static const diamond4 = Asset('assets/divisions/diamond/4.webp');
  static const master1 = Asset('assets/divisions/master/1.webp');
  static const master2 = Asset('assets/divisions/master/2.webp');
  static const master3 = Asset('assets/divisions/master/3.webp');
  static const master4 = Asset('assets/divisions/master/4.webp');
  static const grandmaster1 = Asset('assets/divisions/grandmaster/1.webp');
  static const grandmaster2 = Asset('assets/divisions/grandmaster/2.webp');
  static const grandmaster3 = Asset('assets/divisions/grandmaster/3.webp');
  static const grandmaster4 = Asset('assets/divisions/grandmaster/4.webp');
  static const challenger1 = Asset('assets/divisions/challenger/1.webp');
  static const challenger2 = Asset('assets/divisions/challenger/2.webp');
  static const challenger3 = Asset('assets/divisions/challenger/3.webp');
  static const challenger4 = Asset('assets/divisions/challenger/4.webp');
}
