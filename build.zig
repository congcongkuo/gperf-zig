// A script to build GNU gperf using Zig build system.

const builtin = @import("builtin");
const std = @import("std");

pub fn build(b: *std.Build) !void {
    const upstream = b.dependency("gperf", .{});
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const linkage = b.option(std.builtin.LinkMode, "linkage", "Link mode") orelse .dynamic;

    const libgp = b.addLibrary(.{
        .linkage = .static,
        .name = "libgp",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
        }),
    });

    libgp.addIncludePath(upstream.path("lib"));
    libgp.addIncludePath(b.path("lib"));
    libgp.addCSourceFiles(.{
        .root = upstream.path("lib"),
        .files = &.{
            "cloexec.c",
            "exitfail.c",
            "gl_hash_map.c",
            "gl_map.c",
            "memset_explicit.c",
            "read-file.c",
            "xalloc-die.c",
            "gl_xmap.c",
            "xsize.c",
            "hash.cc",
            "error.c",
            "fopen.c",
            "open.c",
        },
    });

    const gperf = b.addExecutable(.{
        .linkage = linkage,
        .name = "gperf",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
        }),
    });
    gperf.linkLibrary(libgp);

    gperf.addIncludePath(upstream.path("src"));
    gperf.addIncludePath(upstream.path("lib"));
    gperf.addIncludePath(b.path("src"));
    gperf.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &.{
            "version.cc",
            "positions.cc",
            "options.cc",
            "keyword.cc",
            "keyword-list.cc",
            "input.cc",
            "arraylist.cc",
            "bool-array.cc",
            "hash-table.cc",
            "search.cc",
            "output.cc",
            "main.cc",
        },
        .flags = &.{},
        .language = .cpp,
    });

    b.installArtifact(gperf);
}
