package xiangqi

import "sort"

var orthoDirs = [4][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

var diagDirs = [4][2]int{{1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

var horseJumps = [8][4]int{
	{1, 2, 0, 1}, {-1, 2, 0, 1}, {1, -2, 0, -1}, {-1, -2, 0, -1},
	{2, 1, 1, 0}, {2, -1, 1, 0}, {-2, 1, -1, 0}, {-2, -1, -1, 0},
}

func pseudoMoves(board []int, from int) []int {
	p := board[from]
	if p == Empty {
		return nil
	}
	side := pieceSide(p)
	x, y := boardX(from), boardY(from)
	var out []int
	add := func(tx, ty int) {
		if !onBoard(tx, ty) {
			return
		}
		t := board[boardIdx(tx, ty)]
		if t != Empty && pieceSide(t) == side {
			return
		}
		out = append(out, boardIdx(tx, ty))
	}
	switch pieceKind(p) {
	case KindGeneral:
		for _, d := range orthoDirs {
			tx, ty := x+d[0], y+d[1]
			if inPalace(tx, ty, side) {
				add(tx, ty)
			}
		}
	case KindAdvisor:
		for _, d := range diagDirs {
			tx, ty := x+d[0], y+d[1]
			if inPalace(tx, ty, side) {
				add(tx, ty)
			}
		}
	case KindElephant:
		for _, d := range diagDirs {
			tx, ty := x+2*d[0], y+2*d[1]
			if !onBoard(tx, ty) || crossedRiver(ty, side) {
				continue
			}
			if board[boardIdx(x+d[0], y+d[1])] != Empty {
				continue
			}
			add(tx, ty)
		}
	case KindHorse:
		for _, j := range horseJumps {
			lx, ly := x+j[2], y+j[3]
			if !onBoard(lx, ly) || board[boardIdx(lx, ly)] != Empty {
				continue
			}
			add(x+j[0], y+j[1])
		}
	case KindChariot:
		for _, d := range orthoDirs {
			tx, ty := x+d[0], y+d[1]
			for onBoard(tx, ty) {
				t := board[boardIdx(tx, ty)]
				if t != Empty {
					if pieceSide(t) != side {
						out = append(out, boardIdx(tx, ty))
					}
					break
				}
				out = append(out, boardIdx(tx, ty))
				tx += d[0]
				ty += d[1]
			}
		}
	case KindCannon:
		for _, d := range orthoDirs {
			tx, ty := x+d[0], y+d[1]
			jumped := false
			for onBoard(tx, ty) {
				t := board[boardIdx(tx, ty)]
				if !jumped {
					if t == Empty {
						out = append(out, boardIdx(tx, ty))
					} else {
						jumped = true
					}
				} else if t != Empty {
					if pieceSide(t) != side {
						out = append(out, boardIdx(tx, ty))
					}
					break
				}
				tx += d[0]
				ty += d[1]
			}
		}
	case KindSoldier:
		add(x, y+forwardDir(side))
		if crossedRiver(y, side) {
			add(x-1, y)
			add(x+1, y)
		}
	}
	return out
}

func findGeneral(board []int, side int) int {
	target := pieceFor(side, KindGeneral)
	for idx, p := range board {
		if p == target {
			return idx
		}
	}
	return -1
}

func generalAttacked(board []int, sq, bySide int) bool {
	x, y := boardX(sq), boardY(sq)
	for _, d := range orthoDirs {
		tx, ty := x+d[0], y+d[1]
		steps := 1
		jumped := false
		for onBoard(tx, ty) {
			t := board[boardIdx(tx, ty)]
			if t != Empty {
				if !jumped {
					if pieceSide(t) == bySide {
						switch pieceKind(t) {
						case KindChariot:
							return true
						case KindGeneral:
							if steps == 1 && inPalace(x, y, bySide) {
								return true
							}
						}
					}
					jumped = true
				} else {
					if pieceSide(t) == bySide && pieceKind(t) == KindCannon {
						return true
					}
					break
				}
			}
			tx += d[0]
			ty += d[1]
			steps++
		}
	}
	for _, j := range horseJumps {
		hx, hy := x-j[0], y-j[1]
		lx, ly := hx+j[2], hy+j[3]
		if !onBoard(hx, hy) || !onBoard(lx, ly) {
			continue
		}
		if board[boardIdx(lx, ly)] != Empty {
			continue
		}
		if board[boardIdx(hx, hy)] == pieceFor(bySide, KindHorse) {
			return true
		}
	}
	sy := y - forwardDir(bySide)
	if onBoard(x, sy) && board[boardIdx(x, sy)] == pieceFor(bySide, KindSoldier) {
		return true
	}
	if crossedRiver(y, bySide) {
		for _, dx := range [2]int{-1, 1} {
			sx := x + dx
			if onBoard(sx, y) && board[boardIdx(sx, y)] == pieceFor(bySide, KindSoldier) {
				return true
			}
		}
	}
	return false
}

func inCheck(board []int, side int) bool {
	g := findGeneral(board, side)
	if g < 0 {
		return false
	}
	return generalAttacked(board, g, 1-side)
}

func generalsFacing(board []int) bool {
	rg := findGeneral(board, SideRed)
	bg := findGeneral(board, SideBlack)
	if rg < 0 || bg < 0 {
		return false
	}
	if boardX(rg) != boardX(bg) {
		return false
	}
	x := boardX(rg)
	for y := boardY(rg) + 1; y < boardY(bg); y++ {
		if board[boardIdx(x, y)] != Empty {
			return false
		}
	}
	return true
}

func moveLeavesIllegal(board []int, from, to, side int) bool {
	captured := board[to]
	board[to] = board[from]
	board[from] = Empty
	bad := inCheck(board, side) || generalsFacing(board)
	board[from] = board[to]
	board[to] = captured
	return bad
}

func legalMovesFrom(board []int, from int) []int {
	p := board[from]
	if p == Empty {
		return nil
	}
	side := pieceSide(p)
	out := make([]int, 0, 8)
	for _, to := range pseudoMoves(board, from) {
		if !moveLeavesIllegal(board, from, to, side) {
			out = append(out, to)
		}
	}
	sort.Ints(out)
	return out
}

func hasLegalMove(board []int, side int) bool {
	for from, p := range board {
		if p == Empty || pieceSide(p) != side {
			continue
		}
		for _, to := range pseudoMoves(board, from) {
			if !moveLeavesIllegal(board, from, to, side) {
				return true
			}
		}
	}
	return false
}
