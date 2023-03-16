using System.Reflection;

internal class Program {
    private static void Main() {
        foreach (var fileName in Directory.GetFiles(Directory.GetCurrentDirectory(), "*.dll")) {
            AssemblyName name;

            try {
                name = AssemblyName.GetAssemblyName(fileName);
            } catch {
                // Not an assembly. Skip it.
                continue;
            }

            try {
                Console.ForegroundColor = ConsoleColor.DarkGray;
                Console.WriteLine($"Loading assembly: {name}");
                Assembly.Load(name);
            } catch (Exception ex) {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(ex.Message);
            }

            Console.ResetColor();
        }
    }
}
