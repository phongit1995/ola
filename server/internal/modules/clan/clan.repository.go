package clan

import (
	"errors"
	"strings"

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

var (
	ErrClanNotFound             = errors.New("clan not found")
	ErrClanNameTaken            = errors.New("clan name is already taken")
	ErrInsufficientKen          = errors.New("insufficient ken balance")
	ErrNotClanMember            = errors.New("you are not a member of this clan")
	ErrAlreadyClanMember        = errors.New("you are already a member of this clan")
	ErrClanBanned               = errors.New("you are banned from this clan")
	ErrClanClosed               = errors.New("clan is closed for joining")
	ErrClanViewRestricted       = errors.New("clan requires verification to view")
	ErrClanPostRestricted       = errors.New("you are not allowed to post in this clan")
	ErrClanPublicPostRestricted = errors.New("only the clan owner or deputy can post public")
	ErrOwnerCannotLeave         = errors.New("owner cannot leave the clan")
	ErrCannotBanStaff           = errors.New("cannot ban clan staff")
	ErrMemberNotFound           = errors.New("clan member not found")
	ErrNotClanPost              = errors.New("not a post of this clan")
)

type Repository struct {
	db *gorm.DB
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{db: db}
}

func isUniqueViolation(err error) bool {
	return err != nil && strings.Contains(err.Error(), "duplicate key value")
}

type CreateClanParams struct {
	OwnerID     uuid.UUID
	Handle      string
	Description string
	Cost        int
}

type CreateClanResult struct {
	Clan       *models.Clan
	KenBalance int
}

func (r *Repository) CreateClan(p CreateClanParams) (*CreateClanResult, error) {
	var result CreateClanResult

	err := r.db.Transaction(func(tx *gorm.DB) error {
		var owner models.User
		if err := tx.Clauses(clause.Locking{Strength: "UPDATE"}).First(&owner, "id = ?", p.OwnerID).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return apperr.ErrUserNotFound
			}
			return err
		}
		if owner.Ken < p.Cost {
			return ErrInsufficientKen
		}

		clan := &models.Clan{
			Handle:      p.Handle,
			OwnerID:     p.OwnerID,
			Description: p.Description,
			Policy:      models.ClanPolicyFreePost,
			MemberCount: 1,
		}
		if err := tx.Create(clan).Error; err != nil {
			if isUniqueViolation(err) {
				return ErrClanNameTaken
			}
			return err
		}

		member := &models.ClanMember{
			ClanID: clan.ID,
			UserID: p.OwnerID,
			Role:   models.ClanRoleOwner,
		}
		if err := tx.Create(member).Error; err != nil {
			return err
		}

		balanceAfter := owner.Ken - p.Cost
		if p.Cost > 0 {
			if err := tx.Model(&models.User{}).Where("id = ?", p.OwnerID).Update("ken", balanceAfter).Error; err != nil {
				return err
			}
			clanID := clan.ID
			actorID := p.OwnerID
			kenTx := models.KenTransaction{
				UserID:        p.OwnerID,
				Direction:     models.KenDirectionDebit,
				Type:          models.KenTxTypeClanCreate,
				Amount:        p.Cost,
				BalanceBefore: owner.Ken,
				BalanceAfter:  balanceAfter,
				Description:   "create clan #" + p.Handle,
				RefType:       "clan",
				RefID:         &clanID,
				ActorType:     models.KenActorUser,
				ActorID:       &actorID,
			}
			if err := tx.Create(&kenTx).Error; err != nil {
				return err
			}
		}

		result.Clan = clan
		result.KenBalance = balanceAfter
		return nil
	})
	if err != nil {
		return nil, err
	}
	return &result, nil
}

func (r *Repository) GetByID(id uuid.UUID) (*models.Clan, error) {
	var clan models.Clan
	if err := r.db.Preload("Owner").First(&clan, "id = ?", id).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrClanNotFound
		}
		return nil, err
	}
	return &clan, nil
}

func (r *Repository) GetByHandle(handle string) (*models.Clan, error) {
	var clan models.Clan
	if err := r.db.Preload("Owner").First(&clan, "handle = ?", handle).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrClanNotFound
		}
		return nil, err
	}
	return &clan, nil
}

func (r *Repository) UpdateFields(id uuid.UUID, updates map[string]interface{}) error {
	return r.db.Model(&models.Clan{}).Where("id = ?", id).Updates(updates).Error
}

func (r *Repository) IncrementVisit(id uuid.UUID) error {
	return r.db.Model(&models.Clan{}).Where("id = ?", id).
		Update("visit_count", gorm.Expr("visit_count + ?", 1)).Error
}

func (r *Repository) GetMember(clanID, userID uuid.UUID) (*models.ClanMember, error) {
	var member models.ClanMember
	if err := r.db.First(&member, "clan_id = ? AND user_id = ?", clanID, userID).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &member, nil
}

func (r *Repository) GetMemberByRole(clanID uuid.UUID, role models.ClanRole) (*models.ClanMember, error) {
	var member models.ClanMember
	if err := r.db.Preload("User").First(&member, "clan_id = ? AND role = ?", clanID, role).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, err
	}
	return &member, nil
}

func (r *Repository) GetStaff(clanID uuid.UUID) ([]models.ClanMember, error) {
	var staff []models.ClanMember
	err := r.db.Preload("User").
		Where("clan_id = ? AND role IN ?", clanID,
			[]models.ClanRole{models.ClanRoleOwner, models.ClanRoleDeputy, models.ClanRoleAmbassador}).
		Find(&staff).Error
	return staff, err
}

func (r *Repository) ListByUser(userID uuid.UUID) ([]models.Clan, error) {
	var clans []models.Clan
	err := r.db.Preload("Owner").
		Joins("JOIN clan_members cm ON cm.clan_id = clans.id AND cm.deleted_at IS NULL").
		Where("cm.user_id = ?", userID).
		Order("cm.created_at ASC").
		Find(&clans).Error
	return clans, err
}

func (r *Repository) IsBanned(clanID, userID uuid.UUID) (bool, error) {
	var count int64
	err := r.db.Model(&models.ClanBan{}).
		Where("clan_id = ? AND user_id = ?", clanID, userID).
		Count(&count).Error
	return count > 0, err
}

func (r *Repository) Join(clanID, userID uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		member := &models.ClanMember{
			ClanID: clanID,
			UserID: userID,
			Role:   models.ClanRoleMember,
		}
		if err := tx.Create(member).Error; err != nil {
			if isUniqueViolation(err) {
				return ErrAlreadyClanMember
			}
			return err
		}
		return tx.Model(&models.Clan{}).Where("id = ?", clanID).
			Update("member_count", gorm.Expr("member_count + ?", 1)).Error
	})
}

func (r *Repository) Leave(clanID, userID uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		res := tx.Where("clan_id = ? AND user_id = ? AND role != ?", clanID, userID, models.ClanRoleOwner).
			Delete(&models.ClanMember{})
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			return ErrNotClanMember
		}
		return tx.Model(&models.Clan{}).Where("id = ?", clanID).
			Update("member_count", gorm.Expr("member_count - ?", 1)).Error
	})
}

func (r *Repository) ListMembers(clanID uuid.UUID, verifiedOnly bool, limit, offset int) ([]models.ClanMember, int64, error) {
	db := r.db.Model(&models.ClanMember{}).Where("clan_id = ?", clanID)
	if verifiedOnly {
		db = db.Where("verified = ?", true)
	}

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var members []models.ClanMember
	err := db.Preload("User").
		Order("CASE role WHEN 'owner' THEN 0 WHEN 'deputy' THEN 1 WHEN 'ambassador' THEN 2 ELSE 3 END").
		Order("created_at ASC").
		Limit(limit).Offset(offset).
		Find(&members).Error
	if err != nil {
		return nil, 0, err
	}
	return members, total, nil
}

func (r *Repository) AssignRole(clanID, userID uuid.UUID, role models.ClanRole) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&models.ClanMember{}).
			Where("clan_id = ? AND role = ?", clanID, role).
			Update("role", models.ClanRoleMember).Error; err != nil {
			return err
		}

		res := tx.Model(&models.ClanMember{}).
			Where("clan_id = ? AND user_id = ? AND role != ?", clanID, userID, models.ClanRoleOwner).
			Update("role", role)
		if res.Error != nil {
			return res.Error
		}
		if res.RowsAffected == 0 {
			member := &models.ClanMember{
				ClanID: clanID,
				UserID: userID,
				Role:   role,
			}
			if err := tx.Create(member).Error; err != nil {
				if isUniqueViolation(err) {
					return ErrMemberNotFound
				}
				return err
			}
			return tx.Model(&models.Clan{}).Where("id = ?", clanID).
				Update("member_count", gorm.Expr("member_count + ?", 1)).Error
		}
		return nil
	})
}

func (r *Repository) RevokeRole(clanID uuid.UUID, role models.ClanRole) (*models.ClanMember, error) {
	var member models.ClanMember
	err := r.db.Transaction(func(tx *gorm.DB) error {
		if err := tx.First(&member, "clan_id = ? AND role = ?", clanID, role).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return ErrMemberNotFound
			}
			return err
		}
		return tx.Model(&models.ClanMember{}).Where("id = ?", member.ID).
			Update("role", models.ClanRoleMember).Error
	})
	if err != nil {
		return nil, err
	}
	return &member, nil
}

func (r *Repository) SetVerified(clanID, userID uuid.UUID, verified bool) error {
	res := r.db.Model(&models.ClanMember{}).
		Where("clan_id = ? AND user_id = ?", clanID, userID).
		Update("verified", verified)
	if res.Error != nil {
		return res.Error
	}
	if res.RowsAffected == 0 {
		return ErrMemberNotFound
	}
	return nil
}

func (r *Repository) Ban(clanID, userID, bannedBy uuid.UUID) error {
	return r.db.Transaction(func(tx *gorm.DB) error {
		var member models.ClanMember
		err := tx.First(&member, "clan_id = ? AND user_id = ?", clanID, userID).Error
		switch {
		case errors.Is(err, gorm.ErrRecordNotFound):
		case err != nil:
			return err
		case member.Role != models.ClanRoleMember:
			return ErrCannotBanStaff
		default:
			res := tx.Delete(&models.ClanMember{}, "id = ?", member.ID)
			if res.Error != nil {
				return res.Error
			}
			if res.RowsAffected > 0 {
				if err := tx.Model(&models.Clan{}).Where("id = ?", clanID).
					Update("member_count", gorm.Expr("member_count - ?", 1)).Error; err != nil {
					return err
				}
			}
		}

		ban := &models.ClanBan{ClanID: clanID, UserID: userID, BannedBy: bannedBy}
		if err := tx.Create(ban).Error; err != nil {
			if isUniqueViolation(err) {
				return nil
			}
			return err
		}
		return nil
	})
}

func (r *Repository) Unban(clanID, userID uuid.UUID) error {
	return r.db.Where("clan_id = ? AND user_id = ?", clanID, userID).Delete(&models.ClanBan{}).Error
}

func (r *Repository) ListBans(clanID uuid.UUID, limit, offset int) ([]models.ClanBan, int64, error) {
	db := r.db.Model(&models.ClanBan{}).Where("clan_id = ?", clanID)

	var total int64
	if err := db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	var bans []models.ClanBan
	err := db.Preload("User").Order("created_at DESC").Limit(limit).Offset(offset).Find(&bans).Error
	if err != nil {
		return nil, 0, err
	}
	return bans, total, nil
}

func (r *Repository) FindUserByUsername(username string) (*models.User, error) {
	var user models.User
	if err := r.db.First(&user, "LOWER(username) = ?", strings.ToLower(strings.TrimSpace(username))).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, apperr.ErrUserNotFound
		}
		return nil, err
	}
	return &user, nil
}

func (r *Repository) SetMeTop(clanID uuid.UUID, postID *uuid.UUID) error {
	return r.db.Model(&models.Clan{}).Where("id = ?", clanID).Update("me_top_post_id", postID).Error
}

func (r *Repository) ClearMeTopIfMatches(postID uuid.UUID) error {
	return r.db.Model(&models.Clan{}).Where("me_top_post_id = ?", postID).
		Update("me_top_post_id", nil).Error
}

func (r *Repository) canPost(clan *models.Clan, member *models.ClanMember, banned bool) error {
	if banned {
		return ErrClanBanned
	}
	if member != nil && member.Role != models.ClanRoleMember {
		return nil
	}
	switch clan.Policy {
	case models.ClanPolicyFreePost:
		return nil
	case models.ClanPolicyFreeJoin:
		if member == nil {
			return ErrNotClanMember
		}
		return nil
	case models.ClanPolicyVerifiedPost, models.ClanPolicyVerifiedViewAndPost:
		if member == nil {
			return ErrNotClanMember
		}
		if !member.Verified {
			return ErrClanPostRestricted
		}
		return nil
	case models.ClanPolicyClosed:
		return ErrClanPostRestricted
	default:
		return ErrClanPostRestricted
	}
}

func (r *Repository) canView(clan *models.Clan, member *models.ClanMember) error {
	if clan.Policy != models.ClanPolicyVerifiedViewAndPost {
		return nil
	}
	if member == nil {
		return ErrClanViewRestricted
	}
	if member.Role != models.ClanRoleMember || member.Verified {
		return nil
	}
	return ErrClanViewRestricted
}

func (r *Repository) CanPost(userID, clanID uuid.UUID, visibility models.MeVisibility) error {
	clan, err := r.GetByID(clanID)
	if err != nil {
		return err
	}
	member, err := r.GetMember(clanID, userID)
	if err != nil {
		return err
	}
	banned, err := r.IsBanned(clanID, userID)
	if err != nil {
		return err
	}
	if err := r.canPost(clan, member, banned); err != nil {
		return err
	}
	if visibility == models.MeVisibilityPublic {
		if clan.MemberPublicPost {
			if member == nil {
				return ErrNotClanMember
			}
		} else if member == nil || (member.Role != models.ClanRoleOwner && member.Role != models.ClanRoleDeputy) {
			return ErrClanPublicPostRestricted
		}
	}
	return nil
}

func (r *Repository) CanView(userID, clanID uuid.UUID) error {
	clan, err := r.GetByID(clanID)
	if err != nil {
		return err
	}
	member, err := r.GetMember(clanID, userID)
	if err != nil {
		return err
	}
	return r.canView(clan, member)
}

func (r *Repository) OnPostDisabled(postID uuid.UUID) {
	_ = r.ClearMeTopIfMatches(postID)
}
