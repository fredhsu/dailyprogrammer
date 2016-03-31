package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

// Image bitmap
type Image struct {
	Size     Size
	Pixels   [][]RGB
	MaxColor int
}

// Size of image
type Size struct {
	X int
	Y int
}

// RGB Value
type RGB struct {
	Red   int
	Green int
	Blue  int
}

// DrawPoint draws a point
func (image *Image) DrawPoint(rgb RGB, c []string) {
	x, err := strconv.Atoi(c[4])
	y, err := strconv.Atoi(c[5])
	if err != nil {
		log.Fatal("Didn't get XY values")
	}
	image.Pixels[x][y] = rgb
}

// DrawLine draws a Line
func (image *Image) DrawLine(rgb RGB, c []string) {
	x0, err := strconv.Atoi(c[4])
	y0, err := strconv.Atoi(c[5])
	x1, err := strconv.Atoi(c[6])
	y1, err := strconv.Atoi(c[7])

	if err != nil {
		log.Fatal("Didn't get values")
	}
	dx := x1 - x0
	if dx < 0 {
		dx = -dx
	}
	dy := y1 - y0
	if dy < 0 {
		dy = -dy
	}
	var sx, sy int
	if x0 < x1 {
		sx = 1
	} else {
		sx = -1
	}
	if y0 < y1 {
		sy = 1
	} else {
		sy = -1
	}
	e := dx - dy

	for {
		image.Pixels[x0][y0] = rgb

		if x0 == x1 && y0 == y1 {
			break
		}
		e2 := 2 * e
		if e2 > -dy {
			e -= dy
			x0 += sx
		}
		if e2 < dx {
			e += dx
			y0 += sy
		}
	}
}

// DrawRect Draws a rectangle
func (image *Image) DrawRect(rgb RGB, c []string) {
	fmt.Println("drawrect")
	x0, err := strconv.Atoi(c[4])
	y0, err := strconv.Atoi(c[5])
	height, err := strconv.Atoi(c[6])
	width, err := strconv.Atoi(c[7])

	if err != nil {
		log.Fatal("Didn't get values")
	}
	fmt.Printf("height: %d, width: %d\n", height, width)
	for dy := 0; dy < height; dy++ {
		for dx := 0; dx < width; dx++ {
			fmt.Printf("x: %d, y: %d ", dx, dy)
			image.Pixels[x0+dx][y0+dy] = rgb
		}
	}
}

// HandleCommand Processes the command read
func (image *Image) HandleCommand(c []string) {
	r, err := strconv.Atoi(c[1])
	g, err := strconv.Atoi(c[2])
	b, err := strconv.Atoi(c[3])

	if err != nil {
		log.Fatal("Didn't get RGB values")
	}

	rgb := RGB{r, g, b}
	switch {
	case c[0] == "point":
		image.DrawPoint(rgb, c)
	case c[0] == "line":
		image.DrawLine(rgb, c)
	case c[0] == "rect":
		image.DrawRect(rgb, c)
	}
	return
}

// PrintImage gives the final output
func (image *Image) PrintImage() {
	fmt.Println("P3")
	fmt.Println(image.Size)
	fmt.Println("255")
	for _, row := range image.Pixels {
		fmt.Println(row)
	}
}

// InitImage allocates the slices
func InitImage(x, y int) Image {
	image := Image{}
	image.Pixels = make([][]RGB, y)
	for i := range image.Pixels {
		image.Pixels[i] = make([]RGB, x)
	}
	image.Size.X = x
	image.Size.Y = y
	return image
}

func main() {
	file, err := os.Open("./sample-test.txt")
	// file, err := os.Open("./challenge-input")

	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	fields := strings.Fields(scanner.Text())
	x, err := strconv.Atoi(fields[0])
	y, err := strconv.Atoi(fields[1])
	image := InitImage(x, y)
	for scanner.Scan() {
		fields = strings.Fields(scanner.Text())
		image.HandleCommand(fields)
	}
	image.PrintImage()

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
