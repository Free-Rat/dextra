import CShit
import curses
import Foundation

func main() {
    // Initialize ncurses
    initscr()                // Start ncurses mode
    cbreak()                 // Disable line buffering
    noecho()                 // Don’t echo input characters
    keypad(stdscr, true)     // Enable arrow keys and function keys

    // Print a message at a specific location
    let message = "Hello, ncurses from Swift!"
    // mvprintw(10, 10, message)
    mvaddstr(10, 10, message)

    refresh()

    for x in 0...10 {
        for y in 0...10 {
            let x = Int32(x)
            let y = Int32(y)
            mvaddstr(x, y, "X")
            refresh()
        }
    }

    mvaddstr(10, 40, "\(makeResult())")

    // Refresh the screen to show changes
    refresh()

    // Wait for the user to press any key
    getch()

    // Clean up
    endwin()                 // End ncurses mode
}

main()
