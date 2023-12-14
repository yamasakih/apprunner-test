package main

import (
"fmt"
"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "<h1>Good evening, World version1.0.0</h1>")
}

func main() {
  http.HandleFunc("/", helloHandler)
  fmt.Println("Server Start")
  http.ListenAndServe(":80", nil)
}
