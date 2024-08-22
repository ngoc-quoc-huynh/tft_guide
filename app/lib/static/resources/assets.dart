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

  static const logo = Asset('assets/app/logo.svg');

  static const iron1 = Asset('assets/divisions/iron/1.png');
  static const iron2 = Asset('assets/divisions/iron/2.png');
  static const iron3 = Asset('assets/divisions/iron/3.png');
  static const iron4 = Asset('assets/divisions/iron/4.png');
  static const bronze1 = Asset('assets/divisions/bronze/1.png');
  static const bronze2 = Asset('assets/divisions/bronze/2.png');
  static const bronze3 = Asset('assets/divisions/bronze/3.png');
  static const bronze4 = Asset('assets/divisions/bronze/4.png');
  static const silver1 = Asset('assets/divisions/silver/1.png');
  static const silver2 = Asset('assets/divisions/silver/2.png');
  static const silver3 = Asset('assets/divisions/silver/3.png');
  static const silver4 = Asset('assets/divisions/silver/4.png');
  static const gold1 = Asset('assets/divisions/gold/1.png');
  static const gold2 = Asset('assets/divisions/gold/2.png');
  static const gold3 = Asset('assets/divisions/gold/3.png');
  static const gold4 = Asset('assets/divisions/gold/4.png');
  static const platinum1 = Asset('assets/divisions/platinum/1.png');
  static const platinum2 = Asset('assets/divisions/platinum/2.png');
  static const platinum3 = Asset('assets/divisions/platinum/3.png');
  static const platinum4 = Asset('assets/divisions/platinum/4.png');
  static const emerald1 = Asset('assets/divisions/emerald/1.png');
  static const emerald2 = Asset('assets/divisions/emerald/2.png');
  static const emerald3 = Asset('assets/divisions/emerald/3.png');
  static const emerald4 = Asset('assets/divisions/emerald/4.png');
  static const diamond1 = Asset('assets/divisions/diamond/1.png');
  static const diamond2 = Asset('assets/divisions/diamond/2.png');
  static const diamond3 = Asset('assets/divisions/diamond/3.png');
  static const diamond4 = Asset('assets/divisions/diamond/4.png');
  static const master1 = Asset('assets/divisions/master/1.png');
  static const master2 = Asset('assets/divisions/master/2.png');
  static const master3 = Asset('assets/divisions/master/3.png');
  static const master4 = Asset('assets/divisions/master/4.png');
  static const grandmaster1 = Asset('assets/divisions/grandmaster/1.png');
  static const grandmaster2 = Asset('assets/divisions/grandmaster/2.png');
  static const grandmaster3 = Asset('assets/divisions/grandmaster/3.png');
  static const grandmaster4 = Asset('assets/divisions/grandmaster/4.png');
  static const challenger1 = Asset('assets/divisions/challenger/1.png');
  static const challenger2 = Asset('assets/divisions/challenger/2.png');
  static const challenger3 = Asset('assets/divisions/challenger/3.png');
  static const challenger4 = Asset('assets/divisions/challenger/4.png');

  static const bfSword = Asset('assets/items/base/bf_sword.png');
  static const chainVest = Asset('assets/items/base/chain_vest.png');
  static const giantsBelt = Asset('assets/items/base/giants_belt.png');
  static const needlesslyLargeRod =
      Asset('assets/items/base/needlessly_large_rod.png');
  static const negatronCloak = Asset('assets/items/base/negatron_cloak.png');
  static const recurveBow = Asset('assets/items/base/recurve_bow.png');
  static const sparringGloves = Asset('assets/items/base/sparring_gloves.png');
  static const spatula = Asset('assets/items/base/spatula.png');
  static const tearOfTheGoddess =
      Asset('assets/items/base/tear_of_the_goddess.png');

  static const adaptiveHelm = Asset('assets/items/full/adaptive_helm.png');
  static const archangelsStaff =
      Asset('assets/items/full/archangels_staff.png');
  static const bloodthirster = Asset('assets/items/full/bloodthirster.png');
  static const blueBuff = Asset('assets/items/full/blue_buff.png');
  static const brambleVest = Asset('assets/items/full/bramble_vest.png');
  static const crownguard = Asset('assets/items/full/crownguard.png');
  static const deathblade = Asset('assets/items/full/deathblade.png');
  static const dragonsClaw = Asset('assets/items/full/dragons_claw.png');
  static const edgeOfNight = Asset('assets/items/full/edge_of_night.png');
  static const evenshroud = Asset('assets/items/full/evenshroud.png');
  static const gargoyleStoneplate =
      Asset('assets/items/full/gargoyle_stoneplate.png');
  static const giantSlayer = Asset('assets/items/full/giant_slayer.png');
  static const guardbreaker = Asset('assets/items/full/guardbreaker.png');
  static const guinsoosRageblade =
      Asset('assets/items/full/guinsoos_rageblade.png');
  static const handOfJustice = Asset('assets/items/full/hand_of_justice.png');
  static const hextechGunblade =
      Asset('assets/items/full/hextech_gunblade.png');
  static const infinityEdge = Asset('assets/items/full/infinity_edge.png');
  static const ionicSpark = Asset('assets/items/full/ionic_spark.png');
  static const jeweledGauntlet =
      Asset('assets/items/full/jeweled_gauntlet.png');
  static const lastWhisper = Asset('assets/items/full/last_whisper.png');
  static const morellonomicon = Asset('assets/items/full/morellonomicon.png');
  static const nashorsTooth = Asset('assets/items/full/nashors_tooth.png');
  static const protectorsVow = Asset('assets/items/full/protectors_vow.png');
  static const quicksilver = Asset('assets/items/full/quicksilver.png');
  static const rabadonsDeathcap =
      Asset('assets/items/full/rabadons_deathcap.png');
  static const redBuff = Asset('assets/items/full/red_buff.png');
  static const redemption = Asset('assets/items/full/redemption.png');
  static const runaansHurricane =
      Asset('assets/items/full/runaans_hurricane.png');
  static const spearOfShojin = Asset('assets/items/full/spear_of_shojin.png');
  static const statikkShiv = Asset('assets/items/full/statikk_shiv.png');
  static const steadfastHeart = Asset('assets/items/full/steadfast_heart.png');
  static const steraksGage = Asset('assets/items/full/steraks_gage.png');
  static const sunfireCape = Asset('assets/items/full/sunfire_cape.png');
  static const tacticiansCrown =
      Asset('assets/items/full/tacticians_crown.png');
  static const thiefsGloves = Asset('assets/items/full/thiefs_gloves.png');
  static const titansResolve = Asset('assets/items/full/titans_resolve.png');
  static const warmogsArmor = Asset('assets/items/full/warmogs_armor.png');

  // TODO: Extract as icon or precache svg
  static const abilityPower = Asset('assets/item_stats/ability_power.svg');
  static const armor = Asset('assets/item_stats/armor.svg');
  static const attackDamage = Asset('assets/item_stats/attack_damage.svg');
  static const attackSpeed = Asset('assets/item_stats/attack_speed.svg');
  static const crit = Asset('assets/item_stats/crit.svg');
  static const health = Asset('assets/item_stats/health.svg');
  static const magic_resist = Asset('assets/item_stats/magic_resists.svg');
  static const mana = Asset('assets/item_stats/mana.svg');
}
