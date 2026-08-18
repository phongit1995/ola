package wargod

import "math"

const (
	maxHP    = 200
	maxMP    = 100
	maxFury  = 100
	maxArmor = 30
	ultCost  = 100

	dmgSword             = 7
	healHeart            = 5
	manaWater            = 7
	armorShield          = 5
	furyPeach            = 10
	furyDamageMultiplier = 1.5

	fireSwordDamage  = 12
	greaterHeartHeal = 10

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

func scaleFuryDamage(value int) int {
	return int(math.Round(float64(value) * furyDamageMultiplier))
}

func applyDamageThroughArmor(defender *Fighter, incoming int) (damage, armorDamage int) {
	armorDamage = incoming
	if defender.Armor < armorDamage {
		armorDamage = defender.Armor
	}
	defender.Armor -= armorDamage
	damage = incoming - armorDamage
	defender.HP -= damage
	if defender.HP < 0 {
		defender.HP = 0
	}
	return damage, armorDamage
}

func applyTileEffects(attacker, defender *Fighter, counts map[int]int) Effects {
	return applyTileEffectsAtCascade(attacker, defender, counts, 0)
}

func applyTileEffectsAtCascade(
	attacker, defender *Fighter,
	counts map[int]int,
	cascadeLevel int,
) Effects {
	furyChainActive := false
	return applyTileEffectsInCascadeChain(attacker, defender, counts, cascadeLevel, &furyChainActive)
}

func applyTileEffectsInCascadeChain(
	attacker, defender *Fighter,
	counts map[int]int,
	cascadeLevel int,
	furyChainActive *bool,
) Effects {
	effects := Effects{}

	swordDmg := counts[tileSword] * dmgSword
	fireDmg := counts[tileFireSword] * fireSwordDamage

	// Nộ kích hoạt khi đã đầy trước một wave có Kiếm, rồi giữ hệ số sát thương
	// chuỗi sập hiện tại. Đào ăn trong wave chỉ nạp Nộ cho các wave sau.
	hasSwordDamage := swordDmg > 0 || fireDmg > 0
	furied := furyChainActive != nil && *furyChainActive && hasSwordDamage
	if (furyChainActive == nil || !*furyChainActive) && attacker.Fury >= maxFury && hasSwordDamage {
		swordDmg = scaleFuryDamage(swordDmg)
		fireDmg = scaleFuryDamage(fireDmg)
		attacker.Fury = 0
		furied = true
		effects.Furied = true
		if furyChainActive != nil {
			*furyChainActive = true
		}
	} else if furied {
		swordDmg = scaleFuryDamage(swordDmg)
		fireDmg = scaleFuryDamage(fireDmg)
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

	if incomingDamage := swordDmg + fireDmg; incomingDamage > 0 {
		damage, armorDamage := applyDamageThroughArmor(defender, incomingDamage)
		effects.Damage = damage
		effects.ArmorDamage = armorDamage
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
