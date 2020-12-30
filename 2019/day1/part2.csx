var lines = File.ReadLines("input.txt");
var totalFuel = 0;

foreach (var line in lines)
{
    var moduleMass = int.Parse(line);
    var moduleTotalFuel = calculateRequiredFuel(moduleMass);

    totalFuel += moduleTotalFuel;
}

int calculateRequiredFuel(int mass)
{
    var fuel = mass / 3 - 2;

    if (fuel > 0)
        return fuel + calculateRequiredFuel(fuel);

    return 0;
}

Console.WriteLine(totalFuel);
