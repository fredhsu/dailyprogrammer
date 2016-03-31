package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
)

func main() {
	server := "chat.freenode.net:6667"
	nickname := "FredHsu4321"
	username := "fredlhsu"
	realname := nickname

	conn, err := net.Dial("tcp", server)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Fprintf(conn, "NICK ", nickname, "\r\n")
	fmt.Fprintf(conn, "USER ", username, "0 * :", realname, "\r\n")
	for {
		status, err := bufio.NewReader(conn).ReadString('\n')
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(status)
	}
}
