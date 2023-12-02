const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() void {
    var lines = std.mem.split(u8, input, "\n");
    var sum: usize = 0;

    while (lines.next()) |line| {
        const first = parseDigit(line, false);
        const last = parseDigit(line, true);

        sum += first * 10 + last;
    }

    std.debug.print("{}", .{sum});
}

pub fn parseDigit(line: []const u8, reverse: bool) usize {
    for (0..line.len) |i| {
        var pos = i;

        if (reverse) {
            pos = line.len - i - 1;
        }

        var char = line[pos];

        switch (char) {
            '0'...'9' => return char - '0',
            else => continue,
        }
    }

    return 0;
}
