const std = @import("std");
const ArrayList = std.ArrayList;

const input = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.splitSequence(u8, input, "\n");
    var points: usize = 0;

    while (lines.next()) |line| {
        var cardSplit = std.mem.splitSequence(u8, line, ": ");
        _ = cardSplit.next() orelse unreachable;
        var content = cardSplit.next() orelse unreachable;

        var contentSplit = std.mem.splitSequence(u8, content, " | ");
        var winningStr = contentSplit.next() orelse unreachable;
        var haveStr = contentSplit.next() orelse unreachable;

        var it = std.mem.tokenizeSequence(u8, winningStr, " ");
        var winning: ArrayList(usize) = ArrayList(usize).init(std.heap.page_allocator);
        defer winning.deinit();

        while (it.next()) |value| {
            try winning.append(try std.fmt.parseInt(usize, value, 10));
        }

        it = std.mem.tokenizeSequence(u8, haveStr, " ");
        var have: ArrayList(usize) = ArrayList(usize).init(std.heap.page_allocator);
        defer have.deinit();

        while (it.next()) |value| {
            try have.append(try std.fmt.parseInt(usize, value, 10));
        }

        const common = countCommon(winning, have);

        if (common > 0) {
            points += std.math.pow(usize, 2, common - 1);
        }
    }

    std.debug.print("{}", .{points});
}

fn countCommon(winning: ArrayList(usize), have: ArrayList(usize)) usize {
    var count: usize = 0;

    for (winning.items) |witem| {
        for (have.items) |hitem| {
            if (witem == hitem) {
                count += 1;
            }
        }
    }

    return count;
}
