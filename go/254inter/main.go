package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func readInput(filename string) (byte, [][]byte) {
	grid := [][]byte{{}}
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	player := scanner.Bytes()[0]
	scanner.Scan()
	grid[0] = scanner.Bytes()
	for scanner.Scan() {
		grid = append(grid, scanner.Bytes())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	return player, grid
}

func checkNext(enemy byte, grid [][]byte, row, col, dx, dy int) bool {
	fmt.Printf("Checking row: %d col: %d, dx: %d, dy: %d\n", row, col, dx, dy)
	if grid[row+dx][col+dy] == '-' {
		grid[row+dx][col+dy] = '*'
		return true
	}
	if grid[row+dx][col+dy] == enemy {
		return checkNext(enemy, grid, row+dx, col+dy, dx, dy)
	}
	return false
}

func getEnemy(player byte) byte {
	if player == 'X' {
		return 'O'
	} else {
		return 'X'
	}
}

func findMoves(grid [][]byte, row, col int) int {
	// Scan in each direction for enemy
	// Scan one further in same direction for empty
	count := 0
	player := grid[row][col]
	enemy := getEnemy(player)
	for i := -1; i <= 1; i++ {
		for j := -1; j <= 1; j++ {
			if grid[row+i][col+j] == enemy {
				fmt.Println("enemy")
				if checkNext(enemy, grid, row+i, col+j, i, j) {
					count++
				}
			}
		}
	}
	return count
}
func main() {
	player, grid := readInput("./input.txt")
	fmt.Println("Player : ", player)
	fmt.Println(grid)
	count := 0
	for i := range grid {
		for j := range grid[i] {
			if grid[i][j] == player {
				fmt.Printf("Player square at row %d, col %d\n", i, j)
				count += findMoves(grid, i, j)
			}
		}
	}
	fmt.Printf("%d legal moves for %s\n", count, string(player))
	for i := range grid {
		fmt.Println(string(grid[i]))
	}
}
