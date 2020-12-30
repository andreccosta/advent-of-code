var lines = File.ReadLines("input.txt");
var total = 0;

foreach(var line in lines) {
	var mass = int.Parse(line);
	var fuel = mass / 3 - 2;
	total += fuel;
}

Console.WriteLine(total);
