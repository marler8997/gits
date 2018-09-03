module gits.sync;

struct ScopedDirectoryLock
{
    private string dir;
    this(string dir)
    {
        this.dir = dir;
        acquireDirectoryLock(dir);
    }
    ~this()
    {
        releaseDirectoryLock(dir);
    }
}

// Uses something from the OS to lock access to this directory
// from other instance of this same program.
// Note that if a program crashes, the implementation should allow new
// processes to handle this and acquire the lock.
void acquireDirectoryLock(const(char)[] dir)
{
    // TODO: implement
    import std.stdio; writefln("[DEBUG] lock '%s'", dir);
}
void releaseDirectoryLock(const(char)[] dir)
{
    // TODO: implemented
    import std.stdio; writefln("[DEBUG] release '%s'", dir);
}