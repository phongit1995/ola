package admincheckin

import (
	"fmt"
	"net/http"

	"ola-chat-server/internal/models"
	avatarframe "ola-chat-server/internal/modules/avatar-frame"
	"ola-chat-server/internal/modules/checkin"
	"ola-chat-server/internal/modules/megaphone"
	"ola-chat-server/internal/modules/vip"
	"ola-chat-server/internal/utils"
)

func invalid(format string, args ...interface{}) error {
	return utils.NewHTTPError(http.StatusBadRequest, fmt.Sprintf(format, args...))
}

func cleanSlot(in SlotDTO) (models.CheckinSlot, error) {
	slot := models.CheckinSlot{Slot: int16(in.Slot), Gifts: models.CheckinGifts{}}
	if len(in.Gifts) == 0 {
		return slot, nil
	}
	if len(in.Gifts) > checkin.MaxGifts {
		return slot, invalid("Ô %d tối đa %d quà", in.Slot, checkin.MaxGifts)
	}
	if in.Task == nil || !checkin.IsSlotTask(*in.Task) {
		return slot, invalid("Ô %d có quà thì phải chọn nhiệm vụ", in.Slot)
	}
	gifts := make(models.CheckinGifts, 0, len(in.Gifts))
	for gi, gift := range in.Gifts {
		if len(gift.Options) == 0 || len(gift.Options) > checkin.MaxOptions {
			return slot, invalid("Ô %d, quà %d: cần 1 tới %d món", in.Slot, gi+1, checkin.MaxOptions)
		}
		total := 0
		options := make([]models.CheckinGiftOption, 0, len(gift.Options))
		for oi, option := range gift.Options {
			if option.Weight < 1 || option.Weight > checkin.TotalWeight {
				return slot, invalid("Ô %d, quà %d, món %d: tỉ lệ từ 1 tới %d%%", in.Slot, gi+1, oi+1, checkin.TotalWeight)
			}
			total += option.Weight
			reward, err := cleanReward(option.CheckinReward)
			if err != nil {
				return slot, invalid("Ô %d, quà %d, món %d: %s", in.Slot, gi+1, oi+1, err.Error())
			}
			options = append(options, models.CheckinGiftOption{CheckinReward: reward, Weight: option.Weight})
		}
		if total != checkin.TotalWeight {
			return slot, invalid("Ô %d, quà %d: tổng tỉ lệ phải bằng %d%%", in.Slot, gi+1, checkin.TotalWeight)
		}
		gifts = append(gifts, models.CheckinGift{Options: options})
	}
	task := *in.Task
	slot.Gifts = gifts
	slot.Featured = in.Featured
	slot.RequireVip = in.RequireVip
	slot.Task = &task
	return slot, nil
}

type rewardError string

func (e rewardError) Error() string { return string(e) }

func cleanReward(in models.CheckinReward) (models.CheckinReward, error) {
	switch in.Type {
	case models.CheckinRewardVipDays:
		if in.Days < 1 || in.Days > checkin.MaxVipDays {
			return in, rewardError(fmt.Sprintf("số ngày VIP từ 1 tới %d", checkin.MaxVipDays))
		}
		return models.CheckinReward{Type: in.Type, Days: in.Days}, nil
	case models.CheckinRewardVipIcon:
		if in.VipIconID == 0 {
			return in, rewardError("chọn icon VIP")
		}
		if in.VipIconID < vip.VipTypeMinID || in.VipIconID > vip.VipTypeMaxID {
			return in, rewardError(fmt.Sprintf("icon VIP #%d không có trong danh mục", in.VipIconID))
		}
		if in.ExpiresInDays < 0 || in.ExpiresInDays > checkin.MaxItemDays {
			return in, rewardError(fmt.Sprintf("hạn icon VIP tối đa %d ngày", checkin.MaxItemDays))
		}
		return models.CheckinReward{Type: in.Type, VipIconID: in.VipIconID, ExpiresInDays: in.ExpiresInDays}, nil
	case models.CheckinRewardAvatarFrame:
		if in.FrameID == "" {
			return in, rewardError("chọn khung avatar")
		}
		if !avatarframe.IsCatalogFrameID(in.FrameID) {
			return in, rewardError(fmt.Sprintf("khung %s không có trong danh mục", in.FrameID))
		}
		if in.ExpiresInDays < 0 || in.ExpiresInDays > checkin.MaxItemDays {
			return in, rewardError(fmt.Sprintf("hạn khung tối đa %d ngày", checkin.MaxItemDays))
		}
		return models.CheckinReward{Type: in.Type, FrameID: in.FrameID, ExpiresInDays: in.ExpiresInDays}, nil
	case models.CheckinRewardMegaphoneTicket:
		if in.Count < 1 || in.Count > megaphone.TicketMaxPerGrant {
			return in, rewardError(fmt.Sprintf("số vé loa từ 1 tới %d", megaphone.TicketMaxPerGrant))
		}
		if in.ExpiresInDays < 0 || in.ExpiresInDays > megaphone.TicketMaxDays {
			return in, rewardError(fmt.Sprintf("hạn vé loa tối đa %d ngày", megaphone.TicketMaxDays))
		}
		return models.CheckinReward{Type: in.Type, Count: in.Count, ExpiresInDays: in.ExpiresInDays}, nil
	case models.CheckinRewardKen:
		if in.AmountMin != 0 || in.AmountMax != 0 {
			return cleanRandomKen(in)
		}
		if in.Amount < 1 || in.Amount > checkin.MaxKenAmount {
			return in, rewardError(fmt.Sprintf("số KEN từ 1 tới %d", checkin.MaxKenAmount))
		}
		return models.CheckinReward{Type: in.Type, Amount: in.Amount}, nil
	default:
		return in, rewardError("loại quà không hợp lệ")
	}
}

func cleanRandomKen(in models.CheckinReward) (models.CheckinReward, error) {
	step := checkin.KenRandomStep
	if in.AmountMin < step || in.AmountMax > checkin.MaxKenAmount || in.AmountMin >= in.AmountMax {
		return in, rewardError(fmt.Sprintf("KEN ngẫu nhiên: từ %d tới %d, số nhỏ phải bé hơn số lớn", step, checkin.MaxKenAmount))
	}
	if in.AmountMin%step != 0 || in.AmountMax%step != 0 {
		return in, rewardError(fmt.Sprintf("KEN ngẫu nhiên: hai mốc phải tròn %d", step))
	}
	return models.CheckinReward{Type: in.Type, AmountMin: in.AmountMin, AmountMax: in.AmountMax}, nil
}
