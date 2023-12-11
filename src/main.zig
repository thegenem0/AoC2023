const std = @import("std");
const c = @cImport(
    @cInclude("raylib.h"),
);

pub fn main() !void {
    c.InitWindow(1080, 720, "AoC-2023");
    defer c.CloseWindow();

    c.SetConfigFlags(c.FLAG_WINDOW_RESIZABLE | c.FLAG_VSYNC_HINT);

    c.SetTargetFPS(60);

    while (!c.WindowShouldClose()) {
        {
            c.BeginDrawing();
            defer c.EndDrawing();

            c.ClearBackground(c.RAYWHITE);
            c.DrawText("Congrats! You created your first window!", 190, 200, 20, c.LIGHTGRAY);
        }
    }
}
