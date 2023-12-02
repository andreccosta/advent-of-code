const std = @import("std");

const input = @embedFile("input.txt");

const Highest = struct { Red: usize = 0, Green: usize = 0, Blue: usize = 0 };

pub fn main() void {
    var lines = std.mem.split(u8, input, "\n");
    var sum: usize = 0;

    while (lines.next()) |line| {
        if (line.len == 0) {
            continue;
        }

        var highest = Highest{};
        var gameSplit = std.mem.split(u8, line, ": ");
        _ = gameSplit.next() orelse unreachable;
        var content = gameSplit.next() orelse unreachable;
        var sets = std.mem.split(u8, content, "; ");

        while (sets.next()) |set| {
            var parts = std.mem.split(u8, set, ", ");

            while (parts.next()) |part| {
                var partSplit = std.mem.split(u8, part, " ");
                var countStr = partSplit.next() orelse unreachable;
                var color = partSplit.next() orelse unreachable;

                const count = std.fmt.parseUnsigned(usize, countStr, 10) catch unreachable;

                switch (color[0]) {
                    'r' => {
                        if (count > highest.Red) {
                            highest.Red = count;
                        }
                    },
                    'g' => {
                        if (count > highest.Green) {
                            highest.Green = count;
                        }
                    },
                    'b' => {
                        if (count > highest.Blue) {
                            highest.Blue = count;
                        }
                    },
                    else => unreachable,
                }
            }
        }

        sum += highest.Red * highest.Green * highest.Blue;
    }

    std.debug.print("{d}", .{sum});
}
