package main

import (
	"flag"
	"fmt"
	"net/http"
)

func main() {
	// Accept the exact same -text flag our Helm chart is currently passing
	// textPtr := flag.String("text", "Default Go Hello", "Text to display")
	textPtr := flag.String("text", "I AM UNSTOPPABLE. GITOPS IS REAL.", "Text to display")
	flag.Parse()

	// Create a simple web server
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "%s\n", *textPtr)
	})

	// Listen on port 5678, just like the old http-echo container
	fmt.Println("Go Server starting on port 5678...")
	http.ListenAndServe(":5678", nil)
}
// triggering my first CI build
