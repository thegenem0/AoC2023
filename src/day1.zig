const std = @import("std");

pub fn solvePart1(allocator: std.mem.Allocator) ![:0]u8 {
    const input = try std.fs.cwd().readFileAlloc(allocator, "inputs/day01.txt", 1024 * 1024);

    var sum: i32 = 0;

    var line_iter = std.mem.splitScalar(u8, input, '\n');
    while (line_iter.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        const first_digit_char: u8 = first: {
            for (0..line.len) |char_i| {
                if (std.ascii.isDigit(line[char_i])) {
                    break :first line[char_i];
                }
            }
            break :first '?';
        };
        const last_digit_char: u8 = last: {
            for (0..line.len) |i| {
                const char_i = line.len - i - 1;
                if (std.ascii.isDigit(line[char_i])) {
                    break :last line[char_i];
                }
            }
            break :last '?';
        };

        const first_digit = first_digit_char - '0';
        const last_digit = last_digit_char - '0';
        const total = (first_digit * 10) + last_digit;
        sum = sum + total;
    }

    return std.fmt.allocPrintZ(allocator, "{d}\n", .{sum});
}
