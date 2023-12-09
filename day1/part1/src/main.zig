const std = @import("std");

pub fn main() !void {

    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    // -1 is "unset" flag
    var first: i32 = -1;
    var last: i32 = 0;
    var sum: i32 = 0;

    while (true) {
        var byte = in_stream.readByte() catch {
            // end of file
            break;
        };
        // check byte is a number
        if ('0' <= byte and byte <= '9') {
            if(first == -1) {
                // first is not set, this is first digit
                first = byte - '0';
            }
            last = byte - '0';
        }
        if (byte == '\n') {
            // end of line: append result to sum
            sum += 10 * first + last;
            first = -1;
        }
    }

    std.debug.print("{}\n", .{sum});
}
