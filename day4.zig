const std = @import("std");

pub fn main() !void {
    var puzzle = [10][10]u8{
        [_]u8{ 'M', 'M', 'M', 'S', 'X', 'X', 'M', 'A', 'S', 'M' },
        [_]u8{ 'M', 'S', 'A', 'M', 'X', 'M', 'S', 'M', 'S', 'A' },
        [_]u8{ 'A', 'M', 'X', 'S', 'X', 'M', 'A', 'A', 'M', 'M' },
        [_]u8{ 'M', 'S', 'A', 'M', 'A', 'S', 'M', 'S', 'M', 'X' },
        [_]u8{ 'X', 'M', 'A', 'S', 'A', 'M', 'X', 'A', 'M', 'M' },
        [_]u8{ 'X', 'X', 'A', 'M', 'M', 'X', 'X', 'A', 'M', 'A' },
        [_]u8{ 'S', 'M', 'S', 'M', 'S', 'A', 'S', 'X', 'S', 'S' },
        [_]u8{ 'S', 'A', 'X', 'A', 'M', 'A', 'S', 'A', 'A', 'A' },
        [_]u8{ 'M', 'A', 'M', 'M', 'M', 'X', 'M', 'M', 'M', 'M' },
        [_]u8{ 'M', 'X', 'M', 'X', 'A', 'X', 'M', 'A', 'S', 'X' },
    };

    var words_quantity: u8 = 0;

    const alloc = std.heap.page_allocator;
    const map_template = [4]u8{ 'X', 'M', 'A', 'S' };
    var map = std.AutoHashMap(u8, usize).init(alloc);
    defer map.deinit();

    for (map_template, 0..) |char, i| {
        try map.put(char, i);
    }

    for (&puzzle, 0..) |*row, i| {
        if (i == 0) { // only first line
            for (row, 0..) |char, ci| {
                const prev_el = switch (map.get(row[ci - 1])) {
                    null => 0,
                    else => map.get(row[ci - 1]),
                };
                const current_el = switch (map.get(row[ci])) {
                    null => 0,
                    else => map.get(row[ci]),
                };

                if (map.get(char) == 0) {
                    if (puzzle[0][ci + 1] == 1) {
                        continue;
                    } else if (puzzle[1][ci - 1] == 1 or puzzle[1][ci + 1] == 1) {
                        continue;
                    } else {
                        row[ci] = '.';
                    }
                } else if (row[ci - 1] == '.') {
                    row[ci] = '.';
                } else if (current_el - prev_el != 1) {
                    row[ci] = '.';
                } else unreachable;
                words_quantity += 1;
            }
        } else {
            break;
        }
    }

    // std.debug.print("Letter s - {c}", .{puzzle[0][3]});
}
