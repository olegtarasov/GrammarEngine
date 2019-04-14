namespace $rootnamespace$.Properties
{
    public static class ResourceNamesLinux
    {
        public const string Compiler = "compiler";
        public const string GrammarEngine = "solarix_grammar_engine.so";

        public static string Resource(string name) => $"Resources.{name}";
    }
}