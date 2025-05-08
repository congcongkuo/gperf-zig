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
        .name = "gp",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
        }),
    });

    libgp.addIncludePath(upstream.path("lib"));
    libgp.addIncludePath(b.path("lib2"));
    const alloca_h = b.addConfigHeader(.{
        .style = .{ .autoconf_at =  upstream.path("lib/alloca.in.h") },
        .include_path = "alloca.h",
    }, .{
        .HAVE_ALLOCA_H = 1,
    });
    libgp.addConfigHeader(alloca_h);

    libgp.addCSourceFiles(.{
        .root = upstream.path("lib"),
        .files = &.{
            "basename-lgpl.c", 
            "cloexec.c", 
            "exitfail.c",
            "fd-hook.c",
            "free.c",
            "fstat.c",
            "getopt.c",
            "getopt1.c",
            "gl_hash_map.c",
            "malloca.c",
            "gl_map.c",
            "memset_explicit.c",
            "read-file.c",
            "stat-time.c",
            "stdlib.c",
            "unistd.c",
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
    gperf.addIncludePath(b.path("src2"));
    gperf.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &.{
            "arraylist.cc",
            "bool-array.cc",
            "hash-table.cc",
            "input.cc",
            "keyword-list.cc",
            "keyword.cc",
            "main.cc",
            "options.cc",
            "output.cc",
            "positions.cc",
            "search.cc",
            "version.cc"
        },
        .flags = &.{},
        .language = .cpp,
    });

    b.installArtifact(gperf);
}
