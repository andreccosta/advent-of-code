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
            else => {
                var slice: []const u8 = undefined;

                if (reverse) {
                    slice = line[0 .. line.len - i];
                } else {
                    slice = line[i..];
                }

                if (parseNumber(slice, reverse)) |number| {
                    return number;
                }
            },
        }
    }

    return 0;
}

const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn parseNumber(line: []const u8, reverse: bool) ?usize {
    return for (numbers, 1..) |name, i| if (reverse) {
        if (std.mem.endsWith(u8, line, name)) {
            return i;
        }
    } else {
        if (std.mem.startsWith(u8, line, name)) {
            return i;
        }
    } else null;
}
