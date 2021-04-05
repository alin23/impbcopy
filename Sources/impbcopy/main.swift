import Cocoa
import Foundation

func copyToClipboard(_ path: String) -> Bool {
    var imgobj: NSImage?
    if path == "-" {
        imgobj = NSImage(data: FileHandle.standardInput.readDataToEndOfFile())
    } else {
        imgobj = NSImage(contentsOfFile: path)
    }

    guard let image = imgobj else {
        return false
    }

    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    return pasteboard.writeObjects([image])
}

if CommandLine.arguments.count != 2 {
    print(
        """
        Usage:
            Copy file to clipboard:    impbcopy path/to/file
            Copy stdin to clipboard:   cat /path/to/file | impbcopy -
        """)
    exit(EXIT_FAILURE)
}

let success = copyToClipboard(CommandLine.arguments[1])
exit(success ? EXIT_SUCCESS : EXIT_FAILURE)
