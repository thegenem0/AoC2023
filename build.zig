const std = @import("std");
const raylib_build = @import("libs/raylib/src/build.zig");

const CFlags = .{};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    //Build Libraries

    const exe = b.addExecutable(.{
        .name = "AoC2023",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    //Link Raylib
    const raylib = raylib_build.addRaylib(b, target, optimize, .{});
    exe.addIncludePath(.{ .path = "libs/raylib/src" });
    exe.linkLibrary(raylib);

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
