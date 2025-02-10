import ConsoleLib
import curses
import Foundation

ConsoleLib.hello()
hello_func()

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

    // mvaddstr(0, 0, "\(path)")
    // mvaddstr(0, 0, "\(hello_func())")

    // mvaddstr(0, 30, "\(makeResult())")
    // mvaddstr(0, 0, readFile(path: "\(path)/\(fileName)"))
    let fileContent = readFile(path: "\(path)/\(fileName)") ?? "Failed to read file"
    mvaddstr(0, 0, fileContent)

    refresh()
    var cursorX: Int32 = 0
    var cursorY: Int32 = 0
    move(cursorY, cursorX)

    while true {
        let char = getch()

        switch char {
        case 113: // ASCII for 'q'
            break
        case KEY_LEFT:
            if cursorX > 0 {
                cursorX -= 1
            }
        case KEY_RIGHT:
            if cursorX < fileContent.count - 1 {
                cursorX += 1
            }
        case KEY_UP:
            if cursorY > 0 {
                cursorY -= 1
            }
        case KEY_DOWN:
            cursorY += 1

        default:
            refresh()

        }

        move(cursorY, cursorX)
        refresh()

        if char == 113 { // 'q' key to quit
            break
        }

    }
    // while true {
    //     let char = getch()
    //     print(char)
    //     let quitChar: Character = "q"
    //     if char == quitChar.asciiValue! {
    //         break
    //     }
    //     refresh()
    // }
    // Clean up
    endwin()
}

main()

