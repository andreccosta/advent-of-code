var instructions = File.ReadAllText("input.txt")
    .Trim()
    .Split(",")
    .Select(s => int.Parse(s))
    .ToArray();

// OpCode
// 1 - Adds
// 2 - Multiplies
// 99 - Finished

int position = 0;

instructions[1] = 12;
instructions[2] = 2;

void Add(int position)
{
    int input1 = instructions[instructions[position + 1]];
    int input2 = instructions[instructions[position + 2]];
    instructions[instructions[position + 3]] = input1 + input2;
}

void Multiply(int position)
{
    int input1 = instructions[instructions[position + 1]];
    int input2 = instructions[instructions[position + 2]];
    instructions[instructions[position + 3]] = input1 * input2;
}

void Run()
{
    while (position < instructions.Length)
    {
        var opcode = instructions[position];

        switch (opcode)
        {
            case 1:
                Add(position);
                break;
            case 2:
                Multiply(position);
                break;
            case 99:
                return;
        }

        position += 4;
    }
}

Run();

Console.WriteLine(instructions[0]);
