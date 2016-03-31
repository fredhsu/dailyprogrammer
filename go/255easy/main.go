package main

type Light struct {
	State bool
}

func (l *Light) Toggle() {
	if l.State == true {
		l.State = false
	} else {
		l.State = true
	}
}
func CountOn(lights []Light) int {
	count := 0
	for _, light := range lights {
		if light.State {
			count++
		}
	}
	return count
}

func Run(start, end int, lights []Light) {
	if start > end {
		start, end = end, start
	}
	for i := start; i <= end; i++ {
		lights[i].Toggle()
	}
}

func main() {
}
