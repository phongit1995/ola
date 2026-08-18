package wargod

const (
	maxHP    = 200
	maxMP    = 100
	maxFury  = 100
	maxArmor = 30
	ultCost  = 100

	dmgSword    = 7
	healHeart   = 5
	manaWater   = 7
	armorShield = 5
	furyPeach   = 10

	fireSwordDamage  = 12
	greaterHeartHeal = 10

	armorDecay       = 2
	reflectThreshold = 20
	reflectDamage    = 2

	lightningGodDamage          = 20
	cascadeBonusPercentPerLevel = 10
	maximumCascadeLevel         = 3
)

type Fighter struct {
	HP    int `json:"hp"`
	MP    int `json:"mp"`
	Armor int `json:"armor"`
	Fury  int `json:"fury"`
}

type Effects struct {
	Damage      int  `json:"damage"`
	Heal        int  `json:"heal"`
	Mana        int  `json:"mana"`
	Armor       int  `json:"armor"`
	ArmorDamage int  `json:"armorDamage"`
	Fury        int  `json:"fury"`
	Furied      bool `json:"furied,omitempty"`
	Reflect     int  `json:"reflect,omitempty"`
}

func cascadeBonusPercent(cascadeLevel int) int {
	if cascadeLevel < 0 {
		cascadeLevel = 0
	}
	if cascadeLevel > maximumCascadeLevel {
		cascadeLevel = maximumCascadeLevel
	}
	return cascadeLevel * cascadeBonusPercentPerLevel
}

func scaleCascadeValue(value, cascadeLevel int) int {
	return (value*(100+cascadeBonusPercent(cascadeLevel)) + 50) / 100
}

func applyTileEffects(attacker, defender *Fighter, counts map[int]int) Effects {
	return applyTileEffectsAtCascade(attacker, defender, counts, 0)
}

func applyTileEffectsAtCascade(
	attacker, defender *Fighter,
	counts map[int]int,
	cascadeLevel int,
) Effects {
	effects := Effects{}
	defenderArmorBefore := defender.Armor

	swordDmg := counts[tileSword] * dmgSword
	fireDmg := counts[tileFireSword] * fireSwordDamage

	// Nộ chỉ ×2 khi đã đầy TỪ TRƯỚC wave. Đào ăn trong chính wave này chỉ
	// nạp Nộ cho các đòn Kiếm sau, không tự kích hoạt ×2 ngay.
	furied := false
	if attacker.Fury >= maxFury && (swordDmg > 0 || fireDmg > 0) {
		swordDmg *= 2
		fireDmg *= 2
		attacker.Fury = 0
		furied = true
		effects.Furied = true
	}

	swordDmg = scaleCascadeValue(swordDmg, cascadeLevel)
	fireDmg = scaleCascadeValue(fireDmg, cascadeLevel)

	if counts[tilePeach] > 0 {
		gained := scaleCascadeValue(counts[tilePeach]*furyPeach, cascadeLevel)
		if room := maxFury - attacker.Fury; room < gained {
			gained = room
		}
		attacker.Fury += gained
		effects.Fury = gained
	}

	if swordDmg > 0 {
		if furied {
			defender.HP -= swordDmg
			effects.Damage += swordDmg
		} else {
			absorbed := swordDmg
			if defender.Armor < absorbed {
				absorbed = defender.Armor
			}
			defender.Armor -= absorbed
			effects.ArmorDamage += absorbed
			dealt := swordDmg - absorbed
			defender.HP -= dealt
			effects.Damage += dealt
		}
	}

	if fireDmg > 0 {
		defender.HP -= fireDmg
		effects.Damage += fireDmg
	}

	if defender.HP < 0 {
		defender.HP = 0
	}

	if defender.HP > 0 && (counts[tileSword] > 0 || counts[tileFireSword] > 0) && defenderArmorBefore >= reflectThreshold {
		attacker.HP -= reflectDamage
		if attacker.HP < 0 {
			attacker.HP = 0
		}
		effects.Reflect = reflectDamage
	}

	healing := scaleCascadeValue(
		counts[tileHeart]*healHeart+counts[tileGreaterHeart]*greaterHeartHeal,
		cascadeLevel,
	)
	if healing > 0 {
		healed := healing
		if room := maxHP - attacker.HP; room < healed {
			healed = room
		}
		attacker.HP += healed
		effects.Heal = healed
	}

	if counts[tileWater] > 0 {
		gained := scaleCascadeValue(counts[tileWater]*manaWater, cascadeLevel)
		if room := maxMP - attacker.MP; room < gained {
			gained = room
		}
		attacker.MP += gained
		effects.Mana = gained
	}

	if counts[tileShield] > 0 {
		added := scaleCascadeValue(counts[tileShield]*armorShield, cascadeLevel)
		if room := maxArmor - attacker.Armor; room < added {
			added = room
		}
		attacker.Armor += added
		effects.Armor = added
	}

	return effects
}
