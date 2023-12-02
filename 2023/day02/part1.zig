const std = @import("std");

const input = @embedFile("input.txt");

const Configuration = struct {
    pub const Red = 12;
    pub const Green = 13;
    pub const Blue = 14;
};

pub fn main() void {
    var lines = std.mem.split(u8, input, "\n");
    var sum: usize = 0;

    while (lines.next()) |line| {
        if (line.len == 0) {
            continue;
        }

        var isPossible: bool = true;
        var gameSplit = std.mem.split(u8, line, ": ");
        var idStr = gameSplit.next() orelse unreachable;
        const id = std.fmt.parseUnsigned(usize, idStr["Game ".len..], 10) catch unreachable;

        var content = gameSplit.next() orelse unreachable;

        var sets = std.mem.split(u8, content, "; ");

        while (sets.next()) |set| {
            if (!isPossible) {
                break;
            }

            var parts = std.mem.split(u8, set, ", ");

            while (parts.next()) |part| {
                if (!isPossible) {
                    break;
                }

                var partSplit = std.mem.split(u8, part, " ");
                var countStr = partSplit.next() orelse unreachable;
                var color = partSplit.next() orelse unreachable;

                const count = std.fmt.parseUnsigned(usize, countStr, 10) catch unreachable;

                isPossible = switch (color[0]) {
                    'r' => count <= Configuration.Red,
                    'g' => count <= Configuration.Green,
                    'b' => count <= Configuration.Blue,
                    else => unreachable,
                };
            }
        }

        if (isPossible) {
            sum += id;
        }
    }

    std.debug.print("{d}", .{sum});
}
