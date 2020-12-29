class IntCodeComputer
{
    // IntCode computer

    // OpCode
    // 1 - Adds
    // 2 - Multiplies
    // 99 - Finished

    private int[] Instructions;
    private int Position = 0;

    public IntCodeComputer()
    {
        ReadInstructions();
    }

    public void OverrideInstruction(int position, int code)
    {
        Instructions[position] = code;
    }

    public int Run()
    {
        while (Position < Instructions.Length)
        {
            var opcode = Instructions[Position];

            switch (opcode)
            {
                case 1:
                    Add();
                    break;
                case 2:
                    Multiply();
                    break;
                case 99:
                    return Instructions[0];
            }

            Position += 4;
        }

        return Instructions[0];
    }

    public void Reset()
    {
        Position = 0;
        ReadInstructions();
    }

    private void Add()
    {
        int input1 = Instructions[Instructions[Position + 1]];
        int input2 = Instructions[Instructions[Position + 2]];
        Instructions[Instructions[Position + 3]] = input1 + input2;
    }

    private void Multiply()
    {
        int input1 = Instructions[Instructions[Position + 1]];
        int input2 = Instructions[Instructions[Position + 2]];
        Instructions[Instructions[Position + 3]] = input1 * input2;
    }

    private void ReadInstructions()
    {
        Instructions = File.ReadAllText("input.txt")
            .Trim()
            .Split(",")
            .Select(s => int.Parse(s))
            .ToArray();
    }
}

var computer = new IntCodeComputer();
var expectedOutput = 19690720;

foreach (var x in Enumerable.Range(0, 100))
{
    foreach (var y in Enumerable.Range(0, 100))
    {
        computer.Reset();
        computer.OverrideInstruction(1, x);
        computer.OverrideInstruction(2, y);

        var output = computer.Run();

        if (output == expectedOutput)
        {
            Console.WriteLine(100 * x + y);
            return;
        }
    }
}
