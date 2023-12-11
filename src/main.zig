const std = @import("std");
const day1 = @import("day1.zig");
const c = @cImport(
    @cInclude("raylib.h"),
);

pub fn main() !void {
    const c_alloc = std.heap.c_allocator;

    c.InitWindow(1080, 720, "AoC-2023");
    defer c.CloseWindow();

    c.SetConfigFlags(c.FLAG_WINDOW_RESIZABLE | c.FLAG_VSYNC_HINT);

    c.SetTargetFPS(60);

    //const day1_part1_answer = try day1.solvePart1(c_alloc);
    const day1_part2_answer = try day1.solvePart2(c_alloc);

    while (!c.WindowShouldClose()) {
        {
            c.BeginDrawing();
            defer c.EndDrawing();

            c.ClearBackground(c.RAYWHITE);
            c.DrawText(day1_part2_answer, 190, 200, 20, c.LIGHTGRAY);
        }
    }
}
