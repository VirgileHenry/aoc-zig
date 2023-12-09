

fn read_input() {

    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var max_cal: usize = 0;
    var current_cal: usize = 0;

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) {
            if (current_cal > max_cal) {
                max_cal = current_cal;
            }
            current_cal = 0;
        }
        else {
            var cal: usize = 0;
            var i: usize = 0;
            while (i < line.len) : (i += 1) {
                if (line[i] == ' ') {
                    break;
                }
                cal *= 10;
                cal += @as(u8, line[i]) - @as(u8, '0');
            }
            current_cal += cal;
        }
    }

    // display max_cal
    std.debug.print("max_cal: {}\n", .{max_cal});
}