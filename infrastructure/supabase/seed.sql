-- Base Items
INSERT INTO base_item (id, attack_damage)
VALUES ('bf_sword', 10)
ON CONFLICT (id)
DO UPDATE SET
    attack_damage = excluded.attack_damage;

INSERT INTO base_item (id, armor)
VALUES ('chain_vest', 20)
ON CONFLICT (id)
DO UPDATE SET
    armor = excluded.armor;

INSERT INTO base_item (id)
VALUES ('frying_pan')
ON CONFLICT (id)
DO NOTHING;

INSERT INTO base_item (id, health)
VALUES ('giants_belt', 150)
ON CONFLICT (id)
DO UPDATE SET
    health = excluded.health;

INSERT INTO base_item (id, ability_power)
VALUES ('needlessly_large_rod', 10)
ON CONFLICT (id)
DO UPDATE SET
    ability_power = excluded.ability_power;

INSERT INTO base_item (id, magic_resist)
VALUES ('negatron_cloak', 20)
ON CONFLICT (id)
DO UPDATE SET
    magic_resist = excluded.magic_resist;

INSERT INTO base_item (id, attack_speed)
VALUES ('recurve_bow', 10)
ON CONFLICT (id)
DO UPDATE SET
    attack_speed = excluded.attack_speed;

INSERT INTO base_item (id, crit)
VALUES ('sparring_gloves', 20)
ON CONFLICT (id)
DO UPDATE SET
    crit = excluded.crit;

INSERT INTO base_item (id)
VALUES ('spatula')
ON CONFLICT (id)
DO NOTHING;

INSERT INTO base_item (id, mana)
VALUES ('tear_of_the_goddess', 15)
ON CONFLICT (id)
DO UPDATE SET
    mana = excluded.mana;

-- Full Items
INSERT INTO full_item(id, item_id_1, item_id_2, is_active, mana, magic_resist, ability_power)
VALUES ('adaptive_helm', 'negatron_cloak', 'tear_of_the_goddess', true, 15, 20, 15)
ON CONFLICT (id)
DO UPDATE SET
    mana = excluded.mana,
    magic_resist = excluded.magic_resist,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, mana)
VALUES ('archangels_staff', 'needlessly_large_rod', 'tear_of_the_goddess', true, 20, 15)
ON CONFLICT (id)
DO UPDATE SET
    ability_power = excluded.ability_power,
    mana = excluded.mana;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, magic_resist, ability_power)
VALUES ('bloodthirster', 'bf_sword', 'negatron_cloak', true, 20, 20, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    magic_resist = excluded.magic_resist,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, mana, ability_power, attack_damage)
VALUES ('blue_buff', 'tear_of_the_goddess', 'tear_of_the_goddess', true, 20, 20, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    mana = excluded.mana,
    ability_power = excluded.ability_power,
    attack_damage = excluded.attack_damage;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, armor)
VALUES ('bramble_vest', 'chain_vest', 'chain_vest', true, 55)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    armor = excluded.armor;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, armor, health)
VALUES ('crownguard', 'chain_vest', 'needlessly_large_rod', true, 20, 20, 100)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power,
    armor = excluded.armor,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage)
VALUES ('deathblade', 'bf_sword', 'bf_sword', true, 66)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, magic_resist)
VALUES ('dragons_claw', 'negatron_cloak', 'negatron_cloak', true, 65)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    magic_resist = excluded.magic_resist;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, armor)
VALUES ('edge_of_night', 'bf_sword', 'chain_vest', true, 10, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    armor = excluded.armor;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health, magic_resist)
VALUES ('evenshroud', 'giants_belt', 'negatron_cloak', true, 150, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health,
    magic_resist = excluded.magic_resist;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, magic_resist, armor, health)
VALUES ('gargoyle_stoneplate', 'chain_vest', 'negatron_cloak', true, 30, 30, 100)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    magic_resist = excluded.magic_resist,
    armor = excluded.armor,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, attack_speed, ability_power)
VALUES ('giant_slayer', 'bf_sword', 'recurve_bow', true, 30, 10, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    attack_speed = excluded.attack_speed,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health, crit, ability_power, attack_speed)
VALUES ('guardbreaker', 'giants_belt', 'sparring_gloves', true, 150, 20, 10, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health,
    crit = excluded.crit,
    ability_power = excluded.ability_power,
    attack_speed = excluded.attack_speed;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, attack_speed)
VALUES ('guinsoos_rageblade', 'needlessly_large_rod', 'recurve_bow', true, 10, 15)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power,
    attack_speed = excluded.attack_speed;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, mana, crit)
VALUES ('hand_of_justice', 'tear_of_the_goddess', 'sparring_gloves', true, 15, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    mana = excluded.mana,
    crit = excluded.crit;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, ability_power)
VALUES ('hextech_gunblade', 'bf_sword', 'needlessly_large_rod', true, 15, 15)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, crit)
VALUES ('infinity_edge', 'bf_sword', 'sparring_gloves', true, 35, 35)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    crit = excluded.crit;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, magic_resist, health)
VALUES ('ionic_spark', 'needlessly_large_rod', 'negatron_cloak', true, 15, 25, 150)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power,
    magic_resist = excluded.magic_resist,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, crit)
VALUES ('jeweled_gauntlet', 'needlessly_large_rod', 'sparring_gloves', true, 35, 35)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power,
    crit = excluded.crit;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, attack_speed, crit)
VALUES ('last_whisper', 'recurve_bow', 'sparring_gloves', true, 15, 25, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    attack_speed = excluded.attack_speed,
    crit = excluded.crit;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power, health, attack_speed)
VALUES ('morellonomicon', 'giants_belt', 'needlessly_large_rod', true, 25, 150, 10)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power,
    health = excluded.health,
    attack_speed = excluded.attack_speed;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health, attack_speed, ability_power)
VALUES ('nashors_tooth', 'giants_belt', 'recurve_bow', true, 150, 10, 30)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health,
    attack_speed = excluded.attack_speed,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, armor, mana)
VALUES ('protectors_vow', 'chain_vest', 'tear_of_the_goddess', true, 20, 30)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    armor = excluded.armor,
    mana = excluded.mana;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, magic_resist, crit, attack_speed)
VALUES ('quicksilver', 'negatron_cloak', 'sparring_gloves', true, 20, 20, 30)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    magic_resist = excluded.magic_resist,
    crit = excluded.crit,
    attack_speed = excluded.attack_speed;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, ability_power)
VALUES ('rabadons_deathcap', 'needlessly_large_rod', 'needlessly_large_rod', true, 50)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_speed)
VALUES ('red_buff', 'recurve_bow', 'recurve_bow', true, 40)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_speed = excluded.attack_speed;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health, mana)
VALUES ('redemption', 'giants_belt', 'tear_of_the_goddess', true, 150, 15)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health,
    mana = excluded.mana;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, magic_resist, attack_speed, attack_damage)
VALUES ('runaans_hurricane', 'negatron_cloak', 'recurve_bow', true, 20, 10, 25)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    magic_resist = excluded.magic_resist,
    attack_speed = excluded.attack_speed,
    attack_damage = excluded.attack_damage;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, mana, ability_power)
VALUES ('spear_of_shojin', 'bf_sword', 'tear_of_the_goddess', true, 20, 15, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    mana = excluded.mana,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_speed, mana, ability_power)
VALUES ('statikk_shiv', 'recurve_bow', 'tear_of_the_goddess', true, 20, 15, 15)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_speed = excluded.attack_speed,
    mana = excluded.mana,
    ability_power = excluded.ability_power;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, armor, crit, health)
VALUES ('steadfast_heart', 'chain_vest', 'sparring_gloves', true, 20, 20, 250)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    armor = excluded.armor,
    crit = excluded.crit,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_damage, health)
VALUES ('steraks_gage', 'bf_sword', 'giants_belt', true, 15, 200)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_damage = excluded.attack_damage,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health, armor)
VALUES ('sunfire_cape', 'chain_vest', 'giants_belt', true, 250, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health,
    armor = excluded.armor;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, is_special)
VALUES ('tacticians_cape', 'frying_pan', 'spatula', true, true)
ON CONFLICT (id)
DO NOTHING;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, is_special)
VALUES ('tacticians_crown', 'spatula', 'spatula', true, true)
ON CONFLICT (id)
DO NOTHING;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, is_special)
VALUES ('tacticians_shield', 'frying_pan', 'frying_pan', true, true)
ON CONFLICT (id)
DO NOTHING;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, crit, health)
VALUES ('thiefs_gloves', 'sparring_gloves', 'sparring_gloves', true, 20, 150)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    crit = excluded.crit,
    health = excluded.health;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, attack_speed, armor)
VALUES ('titans_resolve', 'chain_vest', 'recurve_bow', true, 10, 20)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    attack_speed = excluded.attack_speed,
    armor = excluded.armor;

INSERT INTO full_item(id, item_id_1, item_id_2, is_active, health)
VALUES ('warmogs_armor', 'giants_belt', 'giants_belt', true, 600)
ON CONFLICT (id)
DO UPDATE SET
    item_id_1 = excluded.item_id_1,
    item_id_2 = excluded.item_id_2,
    health = excluded.health;

-- Patch Notes
INSERT INTO patch_note(id)
VALUES ('initial')
ON CONFLICT (id)
DO NOTHING;

-- Base Items Translation
INSERT INTO base_item_translation(id, language_code, item_id, name, description, hint)
VALUES
    ('bf_sword_de', 'de', 'bf_sword', 'Riesenschwert', 'Gewährt 10% Angriffsschaden (AD).', 'Erhöht den Angriffsschaden. Kann auch den Schaden von Fähigkeiten erhöhen, je nach Beschreibung der Fähigkeit.'),
    ('bf_sword_en', 'en', 'bf_sword', 'B.F. Sword', 'Grants 10% attack damage (AD).', 'Increases attack damage. Can also increase the damage of abilities, depending on the description of the ability.'),
    ('chain_vest_de', 'de', 'chain_vest', 'Kettenweste', 'Gewährt 20 Rüstung.', 'Verringert Angriffsschaden.'),
    ('chain_vest_en', 'en', 'chain_vest', 'Chain Vest', 'Grants 20 armor.', 'Reduces attack damage.'),
    ('frying_pan_de', 'de', 'frying_pan', 'Bratpfanne', '… warum sollte es sonst hier sein?', 'Was gibt es da noch zu sagen? Es ist eine goldene BRATPFANNE!'),
    ('frying_pan_en', 'en', 'frying_pan', 'Frying Pan', '… why else would it be here?', 'What else is there to say? It''s a golden FRYING PAN!.'),
    ('giants_belt_de', 'de', 'giants_belt', 'Gürtel des Riesens', 'Gewährt 150 Leben (HP).', 'Je mehr Leben dein Champion hat, desto länger bleibt dieser am Leben.'),
    ('giants_belt_en', 'en', 'giants_belt', 'Giant''s Belt', 'Grants 150 health points (HP).', 'The more health points your champion has, the longer they stay alive.'),
    ('needlessly_large_rod_de', 'de', 'needlessly_large_rod', 'Übergroßer Zauberstab', 'Gewährt 10 Fähigkeitenstärke (AP).', 'Erhöht den Schaden von Fähigkeiten entsprechend der Beschreibung der Fähigkeit.'),
    ('needlessly_large_rod_en', 'en', 'needlessly_large_rod', 'Needlessly Large Rod', 'Grants 10 ability power (AP).', 'Increases the damage of abilities according to the skill description.'),
    ('negatron_cloak_de', 'de', 'negatron_cloak', 'Negatron-Mantel', 'Gewährt 20 Magieresistenz (MR).', 'Verringert Fähigkeitsschaden.'),
    ('negatron_cloak_en', 'en', 'negatron_cloak', 'Negatron Cloak', 'Grants 20 magic resistance (MR).', 'Reduces ability damage.'),
    ('recurve_bow_de', 'de', 'recurve_bow', 'Rekursivbogen', 'Gewährt 10% Angriffstempo.', 'Das Angriffstempo gibt an, wie viele Angriffe pro Sekunde ausgeführt werden.'),
    ('recurve_bow_en', 'en', 'recurve_bow', 'Recurve Bow', 'Grants 10% attack speed.', 'The attack speed indicates how many attacks are performed per second.'),
    ('sparring_gloves_de', 'de', 'sparring_gloves', 'Kampfhandschuhe', 'Gewährt 20% Chance auf kritische Treffer.', 'Bei einem kritischen Treffer verursacht dein Champion zusätzlichen Schaden.'),
    ('sparring_gloves_en', 'en', 'sparring_gloves', 'Sparring Gloves', 'Grants 20% chance to critically strike.', 'On a critical strike, your champion deals additional damage.'),
    ('spatula_de', 'de', 'spatula', 'Pfannenwender', 'Es muss etwas tun …', 'Was gibt es da noch zu sagen? Es ist ein goldener PFANNENWENDER!'),
    ('spatula_en', 'en', 'spatula', 'Spatula', 'It must do something …', 'What else is there to say? It''s a golden SPATULA!'),
    ('tear_of_the_goddess_de', 'de', 'tear_of_the_goddess', 'Träne der Göttin', 'Gewährt 15 Mana.', 'Wenn die Mana-Anzeige des Champions voll ist, wird seine Fähigkeit ausgeführt.'),
    ('tear_of_the_goddess_en', 'en', 'tear_of_the_goddess', 'Tear of the Goddess', 'Grants 15 mana.', 'When the champion''s mana bar is full, its ability is executed.')
ON CONFLICT (id)
DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    hint = EXCLUDED.hint;

-- Full Items Translation
INSERT INTO full_item_translation(id, language_code, item_id, name, description, hint)
VALUES
(
    'adaptive_helm_de',
    'de',
    'adaptive_helm',
    'Adaptiver Helm',
    'Vorne: Gewährt 40 Rüstung und MR. Zusätzlich erhalte 1 Mana, wenn du angegriffen wirst.
Hinten: Gewährt 20 AP und erhalte alle 3 Sekunden 10 Mana.',
'Je nach Situation kannst du den Gegenstand einem Tank oder einem AP Carry geben.'
),
(
    'adaptive_helm_en',
    'en',
    'adaptive_helm',
    'Adaptive Helm',
    'Front: Gain 40 armor and magic resistance. Additionally, gain 1 mana when you are attacked.
Back: Gain 20 AP and gain 10 mana every 3 seconds.', 'Depending on the situation, you can give the item to a tank or an AP Carry.'
),
    ('archangels_staff_de', 'de', 'archangels_staff', 'Stab des Erzengels', 'Gewährt alle 5 Sekunden 30 AP.', 'Auf Champions legen, die lange überleben und deren Fähigkeiten AP basierend sind.'),
    ('archangels_staff_en', 'en', 'archangels_staff', 'Archangel''s Staff', 'Grants 30 AP every 5 seconds.', 'Put on champions who survive for a long time and whose abilities are AP based.'),
    ('bloodthirster_de', 'de', 'bloodthirster', 'Blutdürster', 'Gewährt 20% Omnivampir. Fällt die HP unter 40%, erhält der Träger einen 5 Sekunden Schild in Höhe von 25% seines max. HP.', 'Omnivampir heilt für einen Teil des verursachten Schadens. Auf Champions legen, die viel Schaden verursachen, aber wenig HP haben.'),
    ('bloodthirster_en', 'en', 'bloodthirster', 'Bloodthirster', 'Grants 20% Omnivamp. If HP drops below 40%, the holder receives a shield equal to 25% of their max. HP for 5 seconds.', 'Omnivamp heals for some of the damage dealt. Put on champions that deal a lot of damage but have low HP.'),
    ('blue_buff_de', 'de', 'blue_buff', 'Blauer Buff', 'Fähigkeiten kosten 10 Mana weniger. Wenn der Träger einen Gegner tötet, verursacht der Champion in den nächsten 8 Sekunden 8% mehr Schaden.', 'Auf Champions legen, die nicht mehr als 50 Mana haben und daher ihre Fähigkeit oft ausführen können.'),
    ('blue_buff_en', 'en', 'blue_buff', 'Blue Buff', 'Abilities cost 10 mana less. If the holder gets a takedown, the champion deals 8% more damage over the next 8 seconds.', 'Put on champions who have no more than 50 mana and can therefore execute their ability often.'),
    ('bramble_vest_de', 'de', 'bramble_vest', 'Dornenweste', 'Gewährt 5% max. HP und erhalte 8% weniger AD Schaden. Wenn du angegriffen wirst, erhalten alle Gegner in der Nähe 100 AP Schaden.', 'Effektiv gegen Gegner, die viele normale Angriffe ausführen.'),
    ('bramble_vest_en', 'en', 'bramble_vest', 'Bramble Vest', 'Grants 5% max HP and receives 8% less AD damage. When you are attacked, all adjacent enemies take 100 AP damage.', 'Effective against enemies who perform many normal attacks.'),
    ('crownguard_de', 'de', 'crownguard', 'Kronwacht', 'Gewährt 8 Sekunden lang einen Schild in Höhe von 30% max. HP. Erhalte danach 35 AP.', 'Auf Champions legen, die AP basierend und anfällig für Gegner sind.'),
    ('crownguard_en', 'en', 'crownguard', 'Crownguard', 'Grants a shield of 30% max HP for 8 seconds. Gain 35 AP afterwards.', 'Put on champions that are AP based and vulnerable to enemies.'),
    ('deathblade_de', 'de', 'deathblade', 'Klinge des Todes', 'Verursache 7% mehr Schaden.', 'Auf Champions legen, die viel AD Schaden machen, insbesondere deren Fähigkeit.'),
    ('deathblade_en', 'en', 'deathblade', 'Deathblade', 'Deal 7% bonus damage.', 'Put on champions that do a lot of AD damage, especially their ability.'),
    ('dragons_claw_de', 'de', 'dragons_claw', 'Drachenklaue', 'Gewährt 9% max. HP. Alle 2 Sekunden heilst du dich um 5% der max. HP.', 'Effektiv gegen Gegner mit viel AP.'),
    ('dragons_claw_en', 'en', 'dragons_claw', 'Dragon''s Claw', 'Grants 9% max HP. Every 2 seconds, heal 5% max HP.', 'Effective against enemies with a lot of AP.'),
    ('edge_of_night_de', 'de', 'edge_of_night', 'Saum der Nacht', 'Bei 60% HP wirst du kurzzeitig unangreifbar und negative Effekte werden entfernt. Erhalte dann 15% Angriffsgeschwindigkeit.', 'Auf Champions legen, die viel Schaden verursachen, aber wenig HP haben.'),
    ('edge_of_night_en', 'en', 'edge_of_night', 'Edge of Night', 'At 60% Health, briefly become untargetable and shed negative effects. Then, gain 15% attack speed.', 'Put on champions who deal a lot of damage, but have low HP.'),
    ('evenshroud_de', 'de', 'evenshroud', 'Abendschleier', 'Verringert die Rüstung von Gegnern innerhalb von 2 Feldern um 30%. Erhalte außerdem 10 Sekunden lang 25 Rüstung und MR.', 'Auf Champions legen, die vorne sind, viel aushalten und wenn der Gegner viel Rüstung hat.'),
    ('evenshroud_en', 'en', 'evenshroud', 'Evenshroud', 'Reduces the armor of enemies within 2 hexes by 30%. Also gains 25 armor and MR for 10 seconds.', 'Put on champions who are at the front, can take a lot of damage and if the enemey has a lot of armor.'),
    ('gargoyle_stoneplate_de', 'de', 'gargoyle_stoneplate', 'Steinpanzer des Wasserspeiers', 'Gewährt 10 Rüstung und 10 MR für jeden Gegner, der den Halter angreift.', 'Auf Champions legen, die viel aushalten sollen.'),
    ('gargoyle_stoneplate_en', 'en', 'gargoyle_stoneplate', 'Gargoyle Stoneplate', 'Gain 10 armor and 10 magic Resist for each enemy targeting the holder.', 'Put on champions who should withstand a lot of damage.'),
    ('giant_slayer_de', 'de', 'giant_slayer', 'Riesenschlächter', 'Verursache 25% mehr Schaden bei Gegnern mit mehr als 1750 max. HP.', 'Effektiv gegen Gegner mit viel HP.'),
    ('giant_slayer_en', 'en', 'giant_slayer', 'Giant Slayer', 'Deal 25% more damage to enemies with more than 1750 max HP.', 'Effective against enemies with a lot of HP.'),
    ('guardbreaker_de', 'de', 'guardbreaker', 'Wächterbrecher', 'Nachdem du einen Schild beschädigt hast, verursache 3 Sekunden lang 25% mehr Schaden.', 'Effektiv gegen Gegner mit vielen Schilden.'),
    ('guardbreaker_en', 'en', 'guardbreaker', 'Guardbreaker', 'After damaging a shield, deal 25% more damage for 3 seconds.', 'Effective against enemies with many shields.'),
    ('guinsoos_rageblade_de', 'de', 'guinsoos_rageblade', 'Guinsoos Wutklinge', 'Angriffe gewähren 5% stapelbare Angriffsgeschwindigkeit.', 'Auf Champions legen, die auf normale Angriffe ausgelegt sind.'),
    ('guinsoos_rageblade_en', 'en', 'guinsoos_rageblade', 'Guinsoo''s Rageblade', 'Attacks grant 5% stacking attack speed.', 'Put on champions that are designed for normal attacks.'),
    ('hand_of_justice_de', 'de', 'hand_of_justice', 'Hand der Gerechtigkeit', 'Gewährt 15% AD und 15 AP. Gewährt 15% Omnivampir. Jeder Runde wird einer dieser Effekte zufällig verdoppelt.', 'Auf Champions legen, die gut Schaden austeilen, aber wenig HP haben.'),
    ('hand_of_justice_en', 'en', 'hand_of_justice', 'Hand of Justice', 'Grants 15% AD and 15 AP. Grants 15% Omnivamp. Each round, one of these effects is randomly doubled.', 'Put on champions who deal good damage but have low HP.'),
    ('hextech_gunblade_de', 'de', 'hextech_gunblade', 'Hextech-Gunblade', 'Gewährt 20% Omnivampir, was auch den Verbündeten mit dem niedrigsten prozentualen HP heilt.', 'Auf Champions legen, deren Fähigkeit viele Feinde trifft oder kontinuierlich Schaden verursacht und so euer Team heilt.'),
    ('hextech_gunblade_en', 'en', 'hextech_gunblade', 'Hextech Gunblade', 'Grants 20% Omnivamp, which also heals the ally with the lowest HP.', 'Put on champions whose ability hits many enemies or continuously deals damage and thus heals your team.'),
    ('infinity_edge_de', 'de', 'infinity_edge', 'Klinge der Unendlichkeit', 'Fähigkeiten können kritisch treffen. Falls sie bereits kritisch treffen können, erhälte 10% kritischen Schaden.', 'Auf Champions legen, deren Fähigkeiten viel AD Schaden verursachen.'),
    ('infinity_edge_en', 'en', 'infinity_edge', 'Infinity Edge', 'Abilities can critically strike. If they can already critically strike, gain 10% critical strike damage instead.', 'Put on champions whose abilities deal a lot of AD damage.'),
    ('ionic_spark_de', 'de', 'ionic_spark', 'Ionischer Funke', 'Verringere die MR innerhalb von 2 Feldern um 50%. Wenn Feinde ihre Fähigkeit einsetzen, erleiden sie magischen Schaden in Höhe von 160% ihres max. Manas.', 'Auf Champions legen, die viel aushalten sollen. Effektiv, wenn dein Team AP basierend ist.'),
    ('ionic_spark_en', 'en', 'ionic_spark', 'Ionic Spark', 'Reduce MR by 50% within 2 hexes. When enemies use their ability, they take magic damage equal to 160% of their max mana.', 'Put on champions who should withstand a lot of damage. Effective when your team is AP based.'),
    ('jeweled_gauntlet_de', 'de', 'jeweled_gauntlet', 'Juwelenbesetzter Handschuh', 'Fähigkeiten können kritisch treffen. Falls sie bereits kritisch teffen können, erhälte 10% kritischen Schaden.', 'Auf Champions legen, deren Fähigkeiten viel AP Schaden verursachen.'),
    ('jeweled_gauntlet_en', 'en', 'jeweled_gauntlet', 'Jeweled Gauntlet', 'Abilities can critically strike. If they can already critically strike, gain 10% critical strike damage instead.', 'Put on champions whose abilities deal a lot of AP damage.'),
    ('last_whisper_de', 'de', 'last_whisper', 'Letzter Atemzug', 'AD Schaden verringert die Rüstung um 30%.', 'Effektiv gegen Gegner mit viel Rüstung.'),
    ('last_whisper_en', 'en', 'last_whisper', 'Last Whisper', 'AD Damage reduce the amor by 30%.', 'Effective against enemies with a lot of amor.'),
    ('morellonomicon_de', 'de', 'morellonomicon', 'Morellonomikon', 'Angriffe und Fähigkeiten fügen Gegnern 1% Verbrennungen zu und reduziert Heilung um 33% für 10 Sekunden.', 'Effektiv gegen Gegner mit Heilung und wenn deine Fähigkeit Flächenschaden verursacht.'),
    ('morellonomicon_en', 'en', 'morellonomicon', 'Morellonomicon', 'Attacks and abilities deal 1% burn on enemies and reduce healing by 33% for 10 seconds.', 'Effective against enemies with healing and when your ability deals area damage.'),
    ('nashors_tooth_de', 'de', 'nashors_tooth', 'Nashors Zahn', 'Gewährt nach Aktivierung einer Fähigkeit 5 Sekunden lang 40 % Angriffstempo.', 'Auf Champions legen, die ihre Fähigkeit oft einsetzen können.'),
    ('nashors_tooth_en', 'en', 'nashors_tooth', 'Nashor''s Tooth', 'After casting an ability, gain 40% attack speed for 5 seconds.', 'Put on champions who can use their ability often.'),
    ('protectors_vow_de', 'de', 'protectors_vow', 'Schwur des Beschützers', 'Bei 40% HP erhalte einen Schild mit 25% max. HP, der bis zu 5 Sekunden anhält, sowie 20 Rüstung und MR.', 'Auf Champions legen, die vorne stehen und viel aushalten sollen.'),
    ('protectors_vow_en', 'en', 'protectors_vow', 'Protector''s Vow', 'At 40% HP, receive a shield with 25% max HP that lasts up to 5 seconds, as well as 20 armor and MR.', 'Put on champions at the front, who should withstand a lot of damage.'),
    ('quicksilver_de', 'de', 'quicksilver', 'Quecksilber', 'Gewährt 14 Sekunden lang Immunität gegen Massenkontrolle. Erhalte während dieser Zeit alle 2 Sekunden 4% Angriffstempo.', 'Effektiv gegen Gegner, die viele Massenkontrollen haben.'),
    ('quicksilver_en', 'en', 'quicksilver', 'Quicksilver', 'Grants immunity to crowd control for 14 seconds. Gain 4% attack speed every 2 seconds during this time.', 'Effective against enemies with a lot of crowd control.'),
    ('rabadons_deathcap_de', 'de', 'rabadons_deathcap', 'Rabadons Todeshaube', 'Verursache 20% zusätzlichen Schaden.', 'Auf Champions legen, die AP basierend sind.'),
    ('rabadons_deathcap_en', 'en', 'rabadons_deathcap', 'Rabadon''s Deathcap', 'Deal 20% bonus damage.', 'Put on champions who are AP based.'),
    ('red_buff_de', 'de', 'red_buff', 'Roter Buff', 'Verursache 6% mehr Schaden. Angriffe und Fähigkeiten fügen Gegnern 1% Verbrennungen zu und reduziert Heilung um 33% für 10 Sekunden.', 'Effektiv gegen Gegner mit Heilung und wenn dein Champion viele Angriffe austeilt oder die Fähigkeit Flächenschaden verursacht.'),
    ('red_buff_en', 'en', 'red_buff', 'Red Buff', 'Attacks and abilities deal 1% burn on enemies and reduce healing by 33% for 10 seconds.', 'Effective against enemies with healing and when your champion deals a lot of attacks or the ability deals area damage.'),
    ('redemption_de', 'de', 'redemption', 'Befreiungsschlag', 'Heile Verbündete innerhalb von 1 Feld alle 5 Sekunden um 15% ihrer fehlenden HP. Außerdem erleiden sie 5 Sekunden lang 10% weniger Schaden.', 'Effektiv gegen lange Kämpfe.'),
    ('redemption_en', 'en', 'redemption', 'Redemption', 'Heal allies within 1 field for 15% of their missing HP every 5 seconds. They also take 10% less damage for 5 seconds.', 'Effective against long fights.'),
    ('runaans_hurricane_de', 'de', 'runaans_hurricane', 'Runaans Wirbelsturm', 'Angriffe feuern einen Bolzen auf einen Gegner in der Nähe, der 55% Angriffsschaden als physischen Schaden verursacht.', 'Auf Champions legen, die auf normale Angriffe ausgelegt sind.'),
    ('runaans_hurricane_en', 'en', 'runaans_hurricane', 'Runaan''s Hurricane', 'Attacks fire a bolt at a nearby enemy, dealing 55% attack damage as physical damage.', 'Put on champions that are based on normal attacks.'),
    ('spear_of_shojin_de', 'de', 'spear_of_shojin', 'Speer von Shojin', 'Angriffe gewähren 5 zusätzliches Mana.', 'Auf Champions legen, die viel Mana haben.'),
    ('spear_of_shojin_en', 'en', 'spear_of_shojin', 'Spear of Shojin', 'Attacks grant 5 additional mana.', 'Put on champions who have a lot of mana.'),
    ('statikk_shiv_de', 'de', 'statikk_shiv', 'Statikks Stich', 'Jeder 3. Angriff entfesselt einen Kettenblitz, der auf 4 Feinde prallt, 35 magischen Schaden verursacht und die MR für 5 Sekunden um 30% verringert.', 'Auf Champions legen, die viele normale Angriffe machen und wenn dein Team AP basierend ist.'),
    ('statikk_shiv_en', 'en', 'statikk_shiv', 'Statikk Shiv', 'Every 3rd attack unleashes a chain lightning that strikes up to 4 enemies, dealing 35 magic damage and reducing MR by 30% for 5 second.', 'Put on champions who make a lot of normal attacks and if your team is AP based.'),
    ('steadfast_heart_de', 'de', 'steadfast_heart', 'Unerschütterliches Herz', 'Du erleidest 8% weniger Schaden. Bei mehr als 50% HP erleidest du stattdessen 15 % weniger Schaden.', 'Auf Champions legen, die viel aushalten sollen.'),
    ('steadfast_heart_en', 'en', 'steadfast_heart', 'Steadfast Heart', 'You take 8% less damage. If you have more than 50% HP, you take 15% less damage instead.', 'Put on champions that should withstand a lot.'),
    ('steraks_gage_de', 'de', 'steraks_gage', 'Steraks Pegel', 'Gewährt 25% max. HP und 35% Angriffsschaden bei 60% HP.', 'Auf Champions legen, die viel aushalten sollen und AD Schaden verursachen.'),
    ('steraks_gage_en', 'en', 'steraks_gage', 'Sterak''s Gage', 'Grants 25% max HP and 35% attack damage at 60% HP.', 'Put on champions that should withstand a lot and deal AD damage.'),
    ('sunfire_cape_de', 'de', 'sunfire_cape', 'Sonnenfeuer-Umhang', 'Alle 2 Sekunden füge einem Gegner innerhalb von 2 Feldern 1% Verbrennung zu und reduziere die Heilung um 33% für 10 Sekunden.', 'Effektiv gegen Gegner mit Heilung und wenn dein Champion viel aushalten soll.'),
    ('sunfire_cape_en', 'en', 'sunfire_cape', 'Sunfire Cape', 'Every 2 seconds, inflict 1% burn on an enemy within 2 hexes and reduce healing by 33% for 10 seconds.', 'Effective against enemies with healing and when your champion should withstand a lot.'),
    ('tacticians_cape_de', 'de', 'tacticians_cape', 'Umhang des Taktikers', 'Dein Team erhält +1 max. Teamgröße. 10% Chance, nach 10 Sekunden Kampf 1 Gold zu erhalten.', 'Was willst du mehr? Du erhältst eine zusätzliche Einheit auf dem Spielfeld und Gold.'),
    ('tacticians_cape_en', 'en', 'tacticians_cape', 'Tactician''s Cape', 'Your team gains +1 max team size. 10% chance to drop 1 gold after 10 seconds of combat.', 'What else do you want? You get one additional unit on the board and gold.'),
    ('tacticians_crown_de', 'de', 'tacticians_crown', 'Krone des Taktikers', 'Dein Team erhält +1 max. Teamgröße.', 'Was willst du mehr? Du erhältst eine zusätzliche Einheit auf dem Spielfeld.'),
    ('tacticians_crown_en', 'en', 'tacticians_crown', 'Tactician''s Crown', 'Your team gains +1 max team size.', 'What else do you want? You get one additional unit on the board.'),
    ('tacticians_shield_de', 'de', 'tacticians_shield', 'Schild des Taktikers', 'Dein Team erhält +1 max. Teamgröße. 10% Chance, erhalte 1 Gold, wenn der Besitzer stirbt.', 'Was willst du mehr? Du erhältst eine zusätzliche Einheit auf dem Spielfeld und Gold.'),
    ('tacticians_shield_en', 'en', 'tacticians_shield', 'Tactician''s Shield', 'Your team gains +1 max team size. 10% chance to drop 1 gold when the holder dies.', 'What else do you want? You get one additional unit on the board and gold.'),
    ('thiefs_gloves_de', 'de', 'thiefs_gloves', 'Handschuh des Diebes', 'Rüste dich jede Runde mit 2 zufälligen Gegenständen aus.', 'Glücksabhängiger Gegenstand, da man zwei zufällige Gegenstände erhält.'),
    ('thiefs_gloves_en', 'en', 'thiefs_gloves', 'Thief''s Gloves', 'Equip yourself with 2 random items each round.', 'Item dependent on luck, as you receive two random items.'),
    ('titans_resolve_de', 'de', 'titans_resolve', 'Entschlossenheit des Titanen', 'Erhält 2% AD und 2 AP, wenn du angreifst oder Schaden nimmst, bis zu 25 Mal stapelbar. Wenn der Stapel voll ist, gewährt es 25 Rüstung und MR.', 'Auf Champions legen, die normale Angriffe ausführen, aber auch mehr aushalten sollen.'),
    ('titans_resolve_en', 'en', 'titans_resolve', 'Titan''s Resolve', 'Gain 2% AD and 2 AP when attacking or taking damage, stacking up to 25 times. When the fully stacked, grants 25 armor and MR.', 'Put on champions that are based on normal attacks, but should also be able to withstand more.'),
    ('warmogs_armor_de', 'de', 'warmogs_armor', 'Warmogs Rüstung', 'Gewährt 8% max. HP.', 'Auf Champions legen, die viel aushalten sollen und deren Fähigkeit auf HP basiert.'),
    ('warmogs_armor_en', 'en', 'warmogs_armor', 'Warmog''s Armor', 'Grants 8% max HP.', 'Put on champions that should be able to withstand a lot and whose ability is based on HP.')
ON CONFLICT (id)
DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    hint = EXCLUDED.hint;

-- Patch Notes Translation
INSERT INTO patch_note_translation(id, language_code, patch_note_id, text)
VALUES
(
    'initial_de',
    'de',
    'initial',
'# Willkommen in der TFT Guide App! 🎉
Wir freuen uns, euch die neuesten Änderungen der TFT Guide App vorstellen zu können.

 ## Features 🚀
- **Gegenstandsdatenbank**: Entdecke unsere umfangreiche Sammlung von 8 Grundgegenständen und 37 Vollgegenständen.
- **Quiz-Feature**: Teste dein Wissen und strebe danach, Herausforderer zu werden – oder bleibe in Eisen.
- **Patch-Notizen**: Bleibe mit unseren Patch-Notizen über die neuesten Updates und Verbesserungen der App informiert.

 ## Danke! 🙏
Wenn du Feedback hast oder auf Probleme stößt, melde dich gerne bei uns.

Viel Spaß beim Strategisieren und möge deine TFT Kämpfe siegreich sein!'
),
(
    'initial_en',
    'en',
    'initial',
'# Welcome to the TFT Guide App! 🎉
 We’re excited to share the latest updates to the TFT Guide App!

 ## Features 🚀
 - **Item database:** Explore our extensive collection of 8 base items and 37 full items.
 - **Quiz Feature:** Test your knowledge and aim to reach Challenger, or avoid being stuck in Iron.
 - **Patch notes:** Stay informed about the latest updates and improvements to the app with our patch notes section.

 ## Thank You! 🙏
 If you have any feedback or encounter any issues, please feel free to reach out.

 Happy strategizing and may your TFT battles be victorious!'
)
ON CONFLICT (id)
DO UPDATE SET
    text = EXCLUDED.text;
