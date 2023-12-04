const std = @import("std");

const input = @embedFile("input.txt");

pub fn splitLines() ![][]const u8 {
    var split = std.mem.splitSequence(u8, input, "\n");

    var list = std.ArrayList([]const u8).init(std.heap.page_allocator);
    defer list.deinit();

    while (split.next()) |line| {
        try list.append(line);
    }

    return list.toOwnedSlice();
}

pub fn main() !void {
    var sum: usize = 0;

    var lines = try splitLines();

    for (lines, 0..) |line, i| {
        var digitsAcc = std.ArrayList(u8).init(std.heap.page_allocator);
        defer digitsAcc.deinit();

        var start_pos: ?usize = null;
        var finish_pos: ?usize = null;

        for (line, 0..) |c, j| {
            switch (c) {
                '0'...'9' => {
                    if (start_pos == null) {
                        start_pos = j;
                    }
                    finish_pos = j;

                    try digitsAcc.append(c);

                    if (j == line.len - 1) {
                        sum += try checkAcc(digitsAcc, lines, line, i, start_pos.?, finish_pos.?);
                    }
                },
                else => {
                    if (digitsAcc.items.len != 0) {
                        sum += try checkAcc(digitsAcc, lines, line, i, start_pos.?, finish_pos.?);

                        digitsAcc.clearAndFree();
                        start_pos = null;
                        finish_pos = null;
                    }
                },
            }
        }
    }

    std.debug.print("{}", .{sum});
}

pub fn checkChar(c: u8) bool {
    return c != '.' and !std.ascii.isDigit(c);
}

pub fn checkSlice(slice: []const u8) bool {
    for (slice) |c| {
        if (checkChar(c)) {
            return true;
        }
    }

    return false;
}

pub fn checkAcc(acc: std.ArrayList(u8), lines: [][]const u8, line: []const u8, index: usize, in_start_pos: usize, in_finish_pos: usize) !usize {
    if (acc.items.len == 0) {
        return 0;
    }

    var value = try std.fmt.parseInt(usize, acc.items, 10);
    var start_pos: usize = in_start_pos;
    var finish_pos: usize = in_finish_pos;

    // check before and after
    if (start_pos > 0) {
        if (checkChar(line[start_pos - 1])) {
            return value;
        }

        start_pos = start_pos - 1;
    }

    if (finish_pos < line.len - 1) {
        if (checkChar(line[finish_pos + 1])) {
            return value;
        }

        finish_pos = finish_pos + 1;
    }

    // check previous line
    if (index > 0) {
        var slice = lines[index - 1][start_pos .. finish_pos + 1];

        if (checkSlice(slice)) {
            return value;
        }
    }

    // check next line
    if (index < lines.len - 1) {
        var slice = lines[index + 1][start_pos .. finish_pos + 1];

        if (checkSlice(slice)) {
            return value;
        }
    }

    return 0;
}
