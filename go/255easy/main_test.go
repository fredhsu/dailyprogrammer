package main

import "testing"

func TestLights(t *testing.T) {
	l := Light{}
	if l.State {
		t.Errorf("Light is on, should be off")
	}
	l.Toggle()
	if !l.State {
		t.Errorf("Light is off, should be on")
	}
}

func TestExample(t *testing.T) {
	n := 10
	lights := make([]Light, n)
	Run(3, 6, lights)
	count := CountOn(lights)
	if count != 4 {
		t.Errorf("Count is %d, should be 4", count)
	}
	Run(0, 4, lights)
	count = CountOn(lights)
	if count != 5 {
		t.Errorf("Count is %d, should be 5", count)
	}
	Run(7, 3, lights)
	count = CountOn(lights)
	if count != 6 {
		t.Errorf("Count is %d, should be 6", count)
	}
	Run(9, 9, lights)
	count = CountOn(lights)
	if count != 7 {
		t.Errorf("Count is %d, should be 7", count)
	}
}

func TestChallenge(t *testing.T) {
	var challengeTest = []struct {
		Start int
		End   int
	}{
		{616, 293},
		{344, 942},
		{27, 524},
		{716, 291},
		{860, 284},
		{74, 928},
		{970, 594},
		{832, 772},
		{343, 301},
		{194, 882},
		{948, 912},
		{533, 654},
		{242, 792},
		{408, 34},
		{162, 249},
		{852, 693},
		{526, 365},
		{869, 303},
		{7, 992},
		{200, 487},
		{961, 885},
		{678, 828},
		{441, 152},
		{394, 453},
	}
	n := 1000
	lights := make([]Light, n)
	for _, c := range challengeTest {
		Run(c.Start, c.End, lights)
	}
	count := CountOn(lights)
	if count != 423 {
		t.Errorf("expected %d, actual %d", count, 423)
	}

}
