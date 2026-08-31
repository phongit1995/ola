//go:generate go run ../../../../cmd/xiangqigen -constants ../../../../../game/xiangqi/logic/constants.gen.ts -parity testdata/parity.json
package xiangqi

type ClientConfig struct {
	GameID            string
	TurnSeconds       int
	BoardWidth        int
	BoardHeight       int
	HalfmoveDrawPlies int
	RepetitionLimit   int
	BoardAlphabet     string
	StartBoard        []int
	StepKinds         []string
	MateReasons       []string
	DrawReasons       []string
}

func ExportClientConfig() ClientConfig {
	return ClientConfig{
		GameID:            GameID,
		TurnSeconds:       TurnSeconds,
		BoardWidth:        BoardWidth,
		BoardHeight:       BoardHeight,
		HalfmoveDrawPlies: HalfmoveDrawPlies,
		RepetitionLimit:   RepetitionLimit,
		BoardAlphabet:     BoardAlphabet,
		StartBoard:        append([]int(nil), startBoard...),
		StepKinds:         []string{StepMove, StepCapture, StepCheck, StepMate, StepDraw},
		MateReasons:       []string{ReasonCheckmate, ReasonStalemate, ReasonPerpetual},
		DrawReasons:       []string{ReasonRepetition, ReasonHalfmove},
	}
}

type ParityFixture struct {
	Version      int                `json:"version"`
	LegalMoves   []ParityLegalMoves `json:"legalMoves"`
	InCheck      []ParityInCheck    `json:"inCheck"`
	Facing       []ParityFacing     `json:"facing"`
	Terminal     []ParityTerminal   `json:"terminal"`
	PositionKeys []ParityKey        `json:"positionKeys"`
}

type ParityLegalMoves struct {
	Board []int `json:"board"`
	From  int   `json:"from"`
	Want  []int `json:"want"`
}

type ParityInCheck struct {
	Board []int `json:"board"`
	Side  int   `json:"side"`
	Want  bool  `json:"want"`
}

type ParityFacing struct {
	Board []int `json:"board"`
	Want  bool  `json:"want"`
}

type ParityTerminal struct {
	Board []int  `json:"board"`
	Side  int    `json:"side"`
	Want  string `json:"want"`
}

type ParityKey struct {
	Board []int  `json:"board"`
	Side  int    `json:"side"`
	Key   string `json:"key"`
}

func fixtureBoard(overrides map[int]string) []int {
	rows := [BoardHeight]string{
		"...K.....",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".........",
		".....k...",
	}
	for y, row := range overrides {
		rows[y] = row
	}
	return mustParseBoard(rows)
}

func terminalKind(board []int, side int) string {
	if hasLegalMove(board, side) {
		return "none"
	}
	if inCheck(board, side) {
		return ReasonCheckmate
	}
	return ReasonStalemate
}

func ExportParityFixture() ParityFixture {
	legalCases := []struct {
		board []int
		from  int
	}{
		{fixtureBoard(map[int]string{4: "....H...."}), boardIdx(4, 4)},
		{fixtureBoard(map[int]string{4: "....H....", 5: "....P...."}), boardIdx(4, 4)},
		{fixtureBoard(map[int]string{2: "....E....", 3: ".....P..."}), boardIdx(4, 2)},
		{fixtureBoard(map[int]string{4: "..E......"}), boardIdx(2, 4)},
		{fixtureBoard(map[int]string{2: "....C....", 6: "....P....", 8: "....r...."}), boardIdx(4, 2)},
		{fixtureBoard(map[int]string{2: "....C....", 3: "....p...."}), boardIdx(4, 2)},
		{fixtureBoard(map[int]string{2: "....C....", 4: "....P....", 5: "....P....", 8: "....r...."}), boardIdx(4, 2)},
		{fixtureBoard(map[int]string{4: "..p.R....", 6: "....P...."}), boardIdx(4, 4)},
		{fixtureBoard(map[int]string{3: "....P...."}), boardIdx(4, 3)},
		{fixtureBoard(map[int]string{6: "....P...."}), boardIdx(4, 6)},
		{fixtureBoard(map[int]string{9: "P....k..."}), boardIdx(0, 9)},
		{fixtureBoard(nil), boardIdx(3, 0)},
		{fixtureBoard(map[int]string{1: "....A...."}), boardIdx(4, 1)},
		{fixtureBoard(map[int]string{0: "....K....", 5: "....R....", 9: "....k...."}), boardIdx(4, 5)},
		{fixtureBoard(map[int]string{3: "...H.....", 7: "...r....."}), boardIdx(3, 3)},
		{fixtureBoard(map[int]string{0: "...AK....", 5: "....r...."}), boardIdx(3, 0)},
	}
	legalFixtures := make([]ParityLegalMoves, 0, len(legalCases))
	for _, c := range legalCases {
		want := legalMovesFrom(c.board, c.from)
		if want == nil {
			want = []int{}
		}
		legalFixtures = append(legalFixtures, ParityLegalMoves{Board: c.board, From: c.from, Want: want})
	}

	checkCases := []struct {
		board []int
		side  int
	}{
		{fixtureBoard(map[int]string{0: "....K....", 5: "....r...."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 3: "....P....", 7: "....c...."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 2: ".....h..."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 1: ".....P...", 2: ".....h..."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 1: "....p...."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 9: "....k...."}), SideRed},
		{fixtureBoard(map[int]string{0: "....K....", 9: "....k...."}), SideBlack},
		{fixtureBoard(nil), SideRed},
	}
	checkFixtures := make([]ParityInCheck, 0, len(checkCases))
	for _, c := range checkCases {
		checkFixtures = append(checkFixtures, ParityInCheck{Board: c.board, Side: c.side, Want: inCheck(c.board, c.side)})
	}

	facingBoards := [][]int{
		fixtureBoard(map[int]string{0: "....K....", 9: "....k...."}),
		fixtureBoard(map[int]string{0: "....K....", 5: "....P....", 9: "....k...."}),
		fixtureBoard(nil),
	}
	facingFixtures := make([]ParityFacing, 0, len(facingBoards))
	for _, board := range facingBoards {
		facingFixtures = append(facingFixtures, ParityFacing{Board: board, Want: generalsFacing(board)})
	}

	terminalCases := []struct {
		board []int
		side  int
	}{
		{fixtureBoard(map[int]string{0: "r...K....", 1: "....r....", 3: "...h....."}), SideRed},
		{fixtureBoard(map[int]string{2: "...p.....", 9: "....k...."}), SideRed},
		{fixtureBoard(map[int]string{0: "r...K....", 1: "....r...."}), SideRed},
	}
	terminalFixtures := make([]ParityTerminal, 0, len(terminalCases))
	for _, c := range terminalCases {
		terminalFixtures = append(terminalFixtures, ParityTerminal{Board: c.board, Side: c.side, Want: terminalKind(c.board, c.side)})
	}

	keyBoards := []struct {
		board []int
		side  int
	}{
		{append([]int(nil), startBoard...), SideRed},
		{append([]int(nil), startBoard...), SideBlack},
		{fixtureBoard(map[int]string{2: "...p.....", 9: "....k...."}), SideRed},
	}
	keyFixtures := make([]ParityKey, 0, len(keyBoards))
	for _, c := range keyBoards {
		keyFixtures = append(keyFixtures, ParityKey{Board: c.board, Side: c.side, Key: positionKey(c.board, c.side)})
	}

	return ParityFixture{
		Version:      1,
		LegalMoves:   legalFixtures,
		InCheck:      checkFixtures,
		Facing:       facingFixtures,
		Terminal:     terminalFixtures,
		PositionKeys: keyFixtures,
	}
}
