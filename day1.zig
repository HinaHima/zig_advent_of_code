const std = @import("std");
const expect = std.testing.expect;

var a = [6]u8{ 3, 4, 2, 1, 3, 3 };
var b = [6]u8{ 4, 3, 5, 3, 9, 3 };

fn sortLists(list: []u8) void {
    std.mem.sort(u8, list, {}, std.sort.asc(u8));
}

pub fn main() !void {
    sortLists(&a);
    sortLists(&b);

    var sum: u8 = 0;

    for (a, 0..) |num, i| {
        const b_num = b[i];

        if (b_num > num) {
            sum += b_num - num;
        } else {
            sum += num - b_num;
        }
    }

    std.debug.print("The sum is {d}", .{sum});
}
