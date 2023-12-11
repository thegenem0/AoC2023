const std = @import("std");
const raylib_build = @import("libs/raylib/src/build.zig");

const CFlags = .{};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    //Build Libraries
    const raylib = raylib_build.addRaylib(b, target, optimize, .{});

    const exe = b.addExecutable(.{
        .name = "AoC2023",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    //Link Libraries
    exe.linkLibrary(raylib);
    // exe.linkSystemLibrary("GL");
    // exe.linkSystemLibrary("rt");
    // exe.linkSystemLibrary("dl");
    // exe.linkSystemLibrary("m");
    // exe.linkSystemLibrary("X11");
    // exe.linkLibC();

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
