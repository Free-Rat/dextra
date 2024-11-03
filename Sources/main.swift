import CShit
import curses
import Foundation

func readFile(path: String) -> String? {
    let contents: String? = try? String(contentsOfFile: path, encoding: .utf8)
    return contents
}

func main() {

    if CommandLine.arguments.count < 2 {
        print("no file path provided")
        exit(1)
    }
    guard let path = ProcessInfo.processInfo.environment["PWD"] else {
        print("cant found PWD environment variable")
        exit(2)
    }
    let fileName = CommandLine.arguments[1]

    // Initialize ncurses
    initscr()                // Start ncurses mode
    cbreak()                 // Disable line buffering
    noecho()                 // Don’t echo input characters
    keypad(stdscr, true)     // Enable arrow keys and function keys

    mvaddstr(0, 0, "\(path)")
    // mvaddstr(0, 30, "\(makeResult())")
    mvaddstr(1, 0, readFile(path: "\(path)/\(fileName)"))

    // Refresh the screen to show changes
    refresh()
    // Wait for the user to press any key
    getch()
    // Clean up
    endwin()                 // End ncurses mode
}

main()
