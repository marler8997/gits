#!/usr/bin/env rund
//!importPath src

module __none;

import std.file : getcwd, exists;
import std.stdio;

import gits.sync : ScopedDirectoryLock;
import gits.config : GitsConfig;

void errorf(T...)(string fmt, T args)
{
    write("Error: ");
    writefln(fmt, args);
}

void usage()
{
    writeln("usage: gits [-options] <command> <args>...");
    writeln();
    writeln("Common gits commands:");
    writeln("   add  Add a git repository");
}

int main(string[] args)
{
    args = args[1 .. $];
    {
        auto newArgsLength = 0;
        scope(exit) args.length = newArgsLength;
        for (size_t i = 0; i < args.length; i++)
        {
            auto arg = args[i];
            if (arg.ptr[0] != '-')
            {
                args[newArgsLength++] = arg;
            }
            else
            {
                errorf("unknown option '%s'", arg);
                return 1;
            }
        }
    }
    if (args.length == 0)
    {
        usage();
        return 1;
    }
    auto command = args[0];
    args = args[1 .. $];
    if (command == "add")
        return add(args);
    errorf("'%s' is not a gits command", command);
    return 1;
}

int add(string[] args)
{
    auto sync = ScopedDirectoryLock(getcwd());
    auto config = GitsConfig("gitsconfig");
    config.load();

    


    errorf("not impl");
    return 1;
}