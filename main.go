package main

import (
"fmt"
"net/http"
"os"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
  envVar := os.Getenv("RDS_SECRET")
  fmt.Fprintf(w, "<h1>Hello World version1.0.0</h1><p>RDS_SECRET: %s</p>", envVar)
}

func main() {
  http.HandleFunc("/", helloHandler)
  fmt.Println("Server Start")
  http.ListenAndServe(":80", nil)
}
