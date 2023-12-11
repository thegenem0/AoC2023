const std = @import("std");

const input_path = "inputs/day01.txt";

pub fn solvePart1(allocator: std.mem.Allocator) ![:0]u8 {
    const input = try std.fs.cwd().readFileAlloc(allocator, input_path, 1024 * 1024);

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

        // ascii table substract
        const first_digit = first_digit_char - '0';
        const last_digit = last_digit_char - '0';
        const total = (first_digit * 10) + last_digit;
        sum = sum + total;
    }

    return std.fmt.allocPrintZ(allocator, "{d}\n", .{sum});
}

pub fn solvePart2(allocator: std.mem.Allocator) ![:0]u8 {
    const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

    const input = try std.fs.cwd().readFileAlloc(allocator, input_path, 1024 * 1024);

    var sum: i32 = 0;

    var line_iter = std.mem.splitScalar(u8, input, '\n');
    while (line_iter.next()) |line| {
        if (line.len == 0) {
            continue;
        }
        const first_digit: i32 = first: {
            for (0..line.len) |char_i| {
                const line_slice = line[char_i..];
                for (numbers, 0..) |word, word_idx| {
                    if (std.mem.startsWith(u8, line_slice, word)) {
                        break :first @as(i32, @intCast(word_idx + 1));
                    }
                }
                if (std.ascii.isDigit(line[char_i])) {
                    break :first (line[char_i] - '0');
                }
            }
            break :first '?';
        };

        const last_digit: i32 = first: {
            for (0..line.len) |i| {
                const char_i = line.len - i - 1;
                const line_slice = line[char_i..];
                for (numbers, 0..) |word, word_idx| {
                    if (std.mem.startsWith(u8, line_slice, word)) {
                        break :first @as(i32, @intCast(word_idx + 1));
                    }
                }
                if (std.ascii.isDigit(line[char_i])) {
                    break :first (line[char_i] - '0');
                }
            }
            break :first '?';
        };

        const total = (first_digit * 10) + last_digit;

        sum += total;
    }

    return std.fmt.allocPrintZ(allocator, "{d}\n", .{sum});
}
