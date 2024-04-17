import math

G = 6.67430e-11  # Gravitational constant
c = 299792458.0  # Speed of light (m/ps)
M = 1.6e42  # Mass of the black hole (kg)
r = 2.4e15  # Schwarzschild radius (meters)

try:
    ProperTime = float(input("Enter the time on Earth: "))
except ValueError:
    print("Please only enter a numeric value.")
    exit()

TimeDilationFactor = math.sqrt(1 - (2 * G * M) / (r * c**2))
DilatedTime = ProperTime * TimeDilationFactor

print(f"Time Dilation Factor (γ): {TimeDilationFactor:.15f}")
print(f"{ProperTime} years is equivalent to {DilatedTime:.2f} years near the black hole.")
