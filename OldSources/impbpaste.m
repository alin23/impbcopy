#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <unistd.h>

@interface NSImage(saveAsPNGWithName)
- (void) saveAsPNGWithName:(NSString*) fileName;
@end

@implementation NSImage(saveAsPNGWithName)

- (void) saveAsPNGWithName:(NSString*) fileName
{
    // Cache the reduced image
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSBitmapImageFileTypePNG properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];
}

@end

BOOL paste_from_clipboard(NSString *path)
{
  // http://stackoverflow.com/a/18124824/148668
  NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
  NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
  NSDictionary *options = [NSDictionary dictionary];
  BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
  if(ok)
  {
    NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
    NSImage *image = [objectsToPaste objectAtIndex:0];
    [image saveAsPNGWithName:path];
    // http://stackoverflow.com/a/3213017/148668
  }else
  {
    printf("Error: Clipboard doesn't seem to contain an image.\n");
  }
  return ok;
}

int main(int argc, char * const argv[])
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  if(argc<2)
  {
    printf("Usage:\n\n"
      "Paste clipboard to file:\n    ./impbpaste path/to/file\n\n");
    return EXIT_FAILURE;
  }
  NSString *path= [NSString stringWithUTF8String:argv[1]];
  BOOL success = paste_from_clipboard(path);
  [pool release];
  return (success?EXIT_SUCCESS:EXIT_FAILURE);
}
