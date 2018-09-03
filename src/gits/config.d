module gits.config;

import std.typecons : Flag, Yes, No;
import std.exception : assumeUnique;

struct GitsConfig
{
    string filename;
    string contents;
    void load()
    {
        import std.file : exists;
        import gits.file : readFile;
        // TODO: should just try to open the file and check the error
        //       code instead of checking if it exists and then opening it
        if (exists(filename))
        {
            this.contents = readFile(filename, Yes.addNull).assumeUnique;
            auto parser = GitsParser(this.contents.ptr, &this);
            parser.parse();
        }
    }
}

private struct GitsParser
{
    const(char)* next;
    GitsConfig* config;
    void parse()
    {
    }
}
