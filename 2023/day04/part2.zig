const std = @import("std");
const ArrayList = std.ArrayList;

const input = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.splitSequence(u8, input, "\n");
    var i: usize = 1;

    var cards = std.ArrayList([2]usize).init(std.heap.page_allocator);

    while (lines.next()) |line| : (i += 1) {
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

        var common = countCommon(winning, have);
        try cards.append([2]usize{ common, 1 });
    }

    var sum: usize = 0;

    for (cards.items, 0..) |item, ci| {
        var common = item[0];
        var count = item[1];

        sum += count;

        if (common > 0) {
            for (ci + 1..ci + common + 1) |oci| {
                cards.items[oci][1] += count;
            }
        }
    }

    std.debug.print("{}", .{sum});
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
