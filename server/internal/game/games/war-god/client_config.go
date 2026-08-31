package wargod

//go:generate go run ../../../../cmd/wargodgen -constants ../../../../../game/war-god/logic/constants.gen.ts -parity testdata/parity.json

// ClientConfig contains server-authoritative values that are generated into
// TypeScript. Returning a snapshot keeps the runtime package as the single
// source of truth without exposing mutable package state to the generator.
type ClientConfig struct {
	TileOrder                   []string
	Grid                        int
	BaseTileCount               int
	SpecialSwordOneIn           int
	SpecialHeartOneIn           int
	SpecialFlyingDartOneIn      int
	MaxHP                       int
	MaxMP                       int
	MaxFury                     int
	FuryDamageMultiplier        float64
	MaxArmor                    int
	MaxExtraTurns               int
	UltCost                     int
	LightningGodDamage          int
	CascadeBonusPercentPerLevel int
	MaximumCascadeLevel         int
	DamageSword                 int
	HealHeart                   int
	ManaWater                   int
	ArmorShield                 int
	FuryPeach                   int
	FireSwordDamage             int
	GreaterHeartHeal            int
	TurnSeconds                 int
}

func ExportClientConfig() ClientConfig {
	return ClientConfig{
		TileOrder:                   append([]string(nil), tileNames[:]...),
		Grid:                        grid,
		BaseTileCount:               baseTileCount,
		SpecialSwordOneIn:           specialSwordOneIn,
		SpecialHeartOneIn:           specialHeartOneIn,
		SpecialFlyingDartOneIn:      specialFlyingDartOneIn,
		MaxHP:                       maxHP,
		MaxMP:                       maxMP,
		MaxFury:                     maxFury,
		FuryDamageMultiplier:        furyDamageMultiplier,
		MaxArmor:                    maxArmor,
		MaxExtraTurns:               maxExtraTurns,
		UltCost:                     ultCost,
		LightningGodDamage:          lightningGodDamage,
		CascadeBonusPercentPerLevel: cascadeBonusPercentPerLevel,
		MaximumCascadeLevel:         maximumCascadeLevel,
		DamageSword:                 dmgSword,
		HealHeart:                   healHeart,
		ManaWater:                   manaWater,
		ArmorShield:                 armorShield,
		FuryPeach:                   furyPeach,
		FireSwordDamage:             fireSwordDamage,
		GreaterHeartHeal:            greaterHeartHeal,
		TurnSeconds:                 turnSeconds,
	}
}
