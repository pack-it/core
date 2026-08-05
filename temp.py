from _decimal import getcontext, Decimal

# Set precision if needed (default is usually 28 digits)
getcontext().prec = 50

# Use Decimal for exact arithmetic
x = Decimal('0.1')
y = Decimal('0.2')
print(x + y)  # Output: 0.3 (exact)
