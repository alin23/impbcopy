import Cocoa
import Foundation

extension NSImage {
    func saveAsPNG(withName fileName: String?) {
        // Cache the reduced image
        var imageData = tiffRepresentation
        var imageRep: NSBitmapImageRep?
        if let imageData = imageData {
            imageRep = NSBitmapImageRep(data: imageData)
        }
        imageData = imageRep?.representation(using: NSBitmapImageRep.FileType.png, properties: [.compressionFactor: NSNumber(value: 1.0)])
        if let imageData = imageData {
            NSData(data: imageData).write(toFile: fileName ?? "", atomically: false)
        }
    }
}

func pasteFromClipboard(_ path: String?) -> Bool {
    let pasteboard = NSPasteboard.general
    let classArray = [NSImage.self]
    let options: [NSPasteboard.ReadingOptionKey: Any] = [:]
    guard pasteboard.canReadObject(forClasses: classArray, options: options) else {
        print("Error: Clipboard doesn't seem to contain an image.")
        return false
    }

    let objectsToPaste = pasteboard.readObjects(forClasses: classArray, options: options)
    guard let image = objectsToPaste?[0] as? NSImage else {
        print("Error: Clipboard doesn't seem to contain an image.")
        return false
    }

    image.saveAsPNG(withName: path)
    return true
}

if CommandLine.arguments.count != 2 {
    print(
        """
        Usage:
          Paste clipboard to file: impbpaste path/to/file
        """)
    exit(EXIT_FAILURE)
}

let success = pasteFromClipboard(CommandLine.arguments[1])
exit(success ? EXIT_SUCCESS : EXIT_FAILURE)
