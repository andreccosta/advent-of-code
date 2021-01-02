var lines = File.ReadAllLines("input.txt")
    .Select(s => s.Trim().Split(","));

struct Coords
{
    public int X { get; set; }
    public int Y { get; set; }

    public Coords(int x, int y)
    {
        X = x;
        Y = y;
    }

    public Coords Clone()
    {
        return new Coords(this.X, this.Y);
    }

    public override string ToString()
    {
        return $"({X},{Y})";
    }

}

IEnumerable<Coords> Move(ref Coords start, char dir, int length)
{
    var points = new List<Coords>();

    for (var i = 0; i < length; i++)
    {
        switch (dir)
        {
            case 'U':
                start.Y += 1;
                break;
            case 'R':
                start.X += 1;
                break;
            case 'D':
                start.Y -= 1;
                break;
            case 'L':
                start.X -= 1;
                break;
        }

        points.Add(start.Clone());
    }

    return points;
}

var linePoints = new List<List<Coords>>();

foreach (var line in lines)
{
    var position = new Coords(0, 0);
    var points = new List<Coords>();

    foreach (var move in line)
    {
        var dir = move[0];
        var length = int.Parse(move[1..]);

        points.AddRange(Move(ref position, dir, length));
    }

    linePoints.Add(points);
}

var intercepts = linePoints[0].Intersect(linePoints[1]);
var minDistance = intercepts.Select(p => Math.Abs(p.X) + Math.Abs(p.Y)).Min();

Console.WriteLine(minDistance);
