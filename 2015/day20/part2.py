import math

target = 36000000

def get_divisors(n):
    small_divisors = [i for i in range(1, int(math.sqrt(n)) + 1) if n % i == 0]
    large_divisors = [n / d for d in small_divisors if n != d * d]
    return small_divisors + large_divisors

house_number = 100000
presents = 0

while presents <=target:
    house_number += 1
    presents = sum(d for d in get_divisors(house_number) if house_number / d <= 50) * 11

print(house_number)
