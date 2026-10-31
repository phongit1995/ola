package constants

const (
	GameMatchSeatsSubquery = `(
		SELECT gmp.user_id FROM game_match_players AS gmp
		WHERE gmp.game_match_id = game_matches.id AND game_matches.player_count > 2
		UNION ALL
		SELECT pair.user_id FROM (VALUES (game_matches.player0_id), (game_matches.player1_id)) AS pair(user_id)
		WHERE game_matches.player_count <= 2
	)`
	GameMatchHasUserCondition = `(game_matches.player0_id = ? OR game_matches.player1_id = ?
		OR (game_matches.player_count > 2 AND EXISTS (
			SELECT 1 FROM game_match_players AS gmp
			WHERE gmp.game_match_id = game_matches.id AND gmp.user_id = ?)))`
)
