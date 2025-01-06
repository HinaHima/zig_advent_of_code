const std = @import("std");

const a = [5]i8{ 7, 6, 4, 2, 1 };
const b = [5]i8{ 1, 2, 7, 8, 9 };
const c = [5]i8{ 9, 7, 6, 2, 1 };
const d = [5]i8{ 1, 3, 2, 4, 5 };
const e = [5]i8{ 8, 6, 4, 4, 1 };
const f = [5]i8{ 1, 3, 6, 7, 9 };

fn isIncreasing(arr: []const i8) bool {
    return if (arr[0] > arr[1]) false else true;
}

fn checkReportSafety(arr: []const i8) void {
    const is_increasing = isIncreasing(arr);
    var is_safe: bool = true;
    var value_to_check: i8 = arr[0];

    for (arr[1..]) |value| {
        if (is_increasing) {
            const margin: i8 = value - value_to_check;

            if (margin <= 3 and margin > 0) {
                value_to_check = value;
                continue;
            } else {
                is_safe = false;
                break;
            }
        } else if (!is_increasing) {
            const margin: i8 = value_to_check - value;

            if (margin <= 3 and margin > 0) {
                value_to_check = value;
                continue;
            } else {
                is_safe = false;
                break;
            }
        }
    }

    if (is_safe) {
        std.debug.print("The report is safe \n", .{});
    } else {
        std.debug.print("The report is not safe \n", .{});
    }
}

pub fn main() !void {
    checkReportSafety(&a);
    checkReportSafety(&b);
    checkReportSafety(&c);
    checkReportSafety(&d);
    checkReportSafety(&e);
    checkReportSafety(&f);
}
