package wargod

const (
	maxHP       = 100
	maxMP       = 100
	maxArmor    = 30
	ultCost     = 50
	ultDamage   = 25
	dmgSword    = 5
	dmgFire     = 4
	dmgStone    = 3
	healHeart   = 4
	manaWater   = 7
	armorShield = 4
)

type Fighter struct {
	HP    int `json:"hp"`
	MP    int `json:"mp"`
	Armor int `json:"armor"`
}

type Effects struct {
	Damage int `json:"damage"`
	Heal   int `json:"heal"`
	Mana   int `json:"mana"`
	Armor  int `json:"armor"`
}

func applyTileEffects(attacker, defender *Fighter, counts map[int]int) Effects {
	effects := Effects{}

	physical := counts[tileSword]*dmgSword + counts[tileStone]*dmgStone
	if physical > 0 {
		absorbed := physical
		if defender.Armor < absorbed {
			absorbed = defender.Armor
		}
		defender.Armor -= absorbed
		dealt := physical - absorbed
		defender.HP -= dealt
		if defender.HP < 0 {
			defender.HP = 0
		}
		effects.Damage += dealt
	}

	magic := counts[tileFire] * dmgFire
	if magic > 0 {
		defender.HP -= magic
		if defender.HP < 0 {
			defender.HP = 0
		}
		effects.Damage += magic
	}

	if counts[tileHeart] > 0 {
		healed := counts[tileHeart] * healHeart
		if room := maxHP - attacker.HP; room < healed {
			healed = room
		}
		attacker.HP += healed
		effects.Heal = healed
	}

	if counts[tileWater] > 0 {
		gained := counts[tileWater] * manaWater
		if room := maxMP - attacker.MP; room < gained {
			gained = room
		}
		attacker.MP += gained
		effects.Mana = gained
	}

	if counts[tileShield] > 0 {
		added := counts[tileShield] * armorShield
		if room := maxArmor - attacker.Armor; room < added {
			added = room
		}
		attacker.Armor += added
		effects.Armor = added
	}

	return effects
}
