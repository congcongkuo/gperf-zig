// A script to build GNU gperf using Zig build system.

const builtin = @import("builtin");
const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    //const t = target.result;
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

    libgp.addIncludePath(b.path("lib"));
    const lib_config_h = b.addConfigHeader(.{
        .style = .{ .autoconf_undef = b.path("lib/config.h.in") },
    }, .{
        .FUNC_FFLUSH_STDIN = 0,
        .GNULIB_CLOSE = 1,
        .GNULIB_FOPEN_GNU = 1,
        .GNULIB_FSCANF = 1,
        .GNULIB_FSTAT = 1,
        .GNULIB_LOCALEDIR = "",
        .GNULIB_MSVC_NOTHROW = 1,
        .GNULIB_SCANF = 1,
        .GNULIB_STAT = 1,
        .GNULIB_STRERROR = 1,
        .GNULIB_TEST_CLOEXEC = 1,
        .GNULIB_TEST_CLOSE = 1,
        .GNULIB_TEST_DUP2 = 1,
        .GNULIB_TEST_FCNTL = 1,
        .GNULIB_TEST_FGETC = 1,
        .GNULIB_TEST_FGETS = 1,
        .GNULIB_TEST_FOPEN = 1,
        .GNULIB_TEST_FOPEN_GNU = 1,
        .GNULIB_TEST_FPRINTF = 1,
        .GNULIB_TEST_FPUTC = 1,
        .GNULIB_TEST_FPUTS = 1,
        .GNULIB_TEST_FREAD = 1,
        .GNULIB_TEST_FREE_POSIX = 1,
        .GNULIB_TEST_FSCANF = 1,
        .GNULIB_TEST_FSTAT = 1,
        .GNULIB_TEST_FTELL = 1,
        .GNULIB_TEST_FTELLO = 1,
        .GNULIB_TEST_FWRITE = 1,
        .GNULIB_TEST_GETC = 1,
        .GNULIB_TEST_GETCHAR = 1,
        .GNULIB_TEST_GETDTABLESIZE = 1,
        .GNULIB_TEST_GETOPT_POSIX = 1,
        .GNULIB_TEST_GETPROGNAME = 1,
        .GNULIB_TEST_LSEEK = 1,
        .GNULIB_TEST_MALLOC_POSIX = 1,
        .GNULIB_TEST_MEMSET_EXPLICIT = 1,
        .GNULIB_TEST_OPEN = 1,
        .GNULIB_TEST_PRINTF = 1,
        .GNULIB_TEST_PUTC = 1,
        .GNULIB_TEST_PUTCHAR = 1,
        .GNULIB_TEST_PUTS = 1,
        .GNULIB_TEST_REALLOC_POSIX = 1,
        .GNULIB_TEST_SCANF = 1,
        .GNULIB_TEST_STAT = 1,
        .GNULIB_TEST_STRERROR = 1,
        .GNULIB_TEST_VFPRINTF = 1,
        .GNULIB_TEST_VPRINTF = 1,
        .GNULIB_XALLOC_DIE = 1,
        .HAVE_ALLOCA = 1,
        .HAVE_ALLOCA_H = 1,
        .HAVE_C_VARARRAYS = 1,
        .HAVE_DECL_ECVT = 1,
        .HAVE_DECL_EXECVPE = 0,
        .HAVE_DECL_FCLOSEALL = 0,
        .HAVE_DECL_FCVT = 1,
        .HAVE_DECL_FTELLO = 1,
        .HAVE_DECL_GCVT = 1,
        .HAVE_DECL_GETDTABLESIZE = 1,
        .HAVE_DECL_GETW = 1,
        .HAVE_DECL_PROGRAM_INVOCATION_NAME = 1,
        .HAVE_DECL_PUTW = 1,
        .HAVE_DECL_STRERROR_R = 1,
        .HAVE_DECL_WCSDUP = 1,
        .HAVE_FCNTL = 1,
        .HAVE_GETDTABLESIZE = 1,
        .HAVE_GETOPT_H = 1,
        .HAVE_GETOPT_LONG_ONLY = 1,
        .HAVE_GETPROGNAME = 1,
        .HAVE_INTTYPES_H = 1,
        .HAVE_LANGINFO_CODESET = 1,
        .HAVE_LIMITS_H = 1,
        .HAVE_LONG_LONG_INT = 1,
        .HAVE_LSTAT = 1,
        .HAVE_MALLOC_0_NONNULL = 1,
        .HAVE_MALLOC_POSIX = 1,
        .HAVE_MALLOC_PTRDIFF = 1,
        .HAVE_MEMSET_S = 1,
        .HAVE_MEMSET_S_SUPPORTS_ZERO = 1,
        .HAVE_REALLOC_0_NONNULL = 1,
        .HAVE_STDBOOL_H = 1,
        .HAVE_STDCKDINT_H = 1,
        .HAVE_STDINT_H = 1,
        .HAVE_STDIO_H = 1,
        .HAVE_STDLIB_H = 1,
        .HAVE_STRERROR_R = 1,
        .HAVE_STRINGS_H = 1,
        .HAVE_STRING_H = 1,
        .HAVE_STRUCT_STAT_ST_ATIMESPEC_TV_NSEC = 1,
        .HAVE_STRUCT_STAT_ST_BIRTHTIMESPEC_TV_NSEC = 1,
        .HAVE_SYMLINK = 1,
        .HAVE_SYS_PARAM_H = 1,
        .HAVE_SYS_SOCKET_H = 1,
        .HAVE_SYS_STAT_H = 1,
        .HAVE_SYS_TIME_H = 1,
        .HAVE_SYS_TYPES_H = 1,
        .HAVE_UNISTD_H = 1,
        .HAVE_UNSIGNED_LONG_LONG_INT = 1,
        .HAVE_WCHAR_H = 1,
        .HAVE_WINT_T = 1,
        .HAVE_WORKING_O_NOATIME = 1,
        .HAVE_WORKING_O_NOFOLLOW = 1,
        .HAVE_XLOCALE_H = 1,
        .HAVE___HEADER_INLINE = 1,
        .OPEN_TRAILING_SLASH_BUG = 1,
        .PACKAGE = "gperf",
        .PACKAGE_BUGREPORT = "",
        .PACKAGE_NAME = "",
        .PACKAGE_STRING = "gperf 3.3",
        .PACKAGE_TARNAME = "gperf",
        .PACKAGE_URL = "",
        .PACKAGE_VERSION = "3.3",
        .PROMOTED_MODE_T = "int",
        .REPLACE_FUNC_STAT_FILE = 1,
        .REPLACE_STRERROR_0 = 1,
        .STDC_HEADERS = 1,
        .VERSION = "3.3",
        ._LINUX_SOURCE_COMPAT = 1,
        ._USE_STD_STAT = 1,
        .__GETOPT_PREFIX = "rpl_",

    });

    libgp.addConfigHeader(lib_config_h);
    libgp.addCSourceFiles(.{
        .root = b.path("lib"),
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

    gperf.addIncludePath(b.path("src"));
    gperf.addIncludePath(b.path("lib"));
    const src_config_h = b.addConfigHeader(.{
        .style = .{ .autoconf_undef = b.path("src/config.h.in") },
    }, .{
        .HAVE_DYNAMIC_ARRAY = 1,
        .PACKAGE_BUGREPORT = "",
        .PACKAGE_NAME = "",
        .PACKAGE_STRING = "",
        .PACKAGE_TARNAME = "",
        .PACKAGE_URL = "",
        .PACKAGE_VERSION = ""
    });
    gperf.addConfigHeader(src_config_h);
    gperf.addCSourceFiles(.{
        .root = b.path("src"),
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

        gperf.installConfigHeader(lib_config_h);
    b.installArtifact(gperf);
}
