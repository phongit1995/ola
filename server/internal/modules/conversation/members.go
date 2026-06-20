package conversation

import "github.com/google/uuid"

func IsActiveMember(members []ConversationMember, userID uuid.UUID) bool {
	for _, m := range members {
		if m.UserID == userID && m.IsActive {
			return true
		}
	}
	return false
}

func IsMember(members []ConversationMember, userID uuid.UUID) bool {
	for _, m := range members {
		if m.UserID == userID {
			return true
		}
	}
	return false
}

func ActiveMemberIDs(members []ConversationMember) []uuid.UUID {
	ids := make([]uuid.UUID, 0, len(members))
	for _, m := range members {
		if m.IsActive {
			ids = append(ids, m.UserID)
		}
	}
	return ids
}
