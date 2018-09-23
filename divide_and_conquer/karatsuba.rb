# In this programming assignment you will implement one or more of the integer
# multiplication algorithms described in lecture.

# To get the most out of this assignment, your program should restrict itself to
# multiplying only pairs of single-digit numbers. You can implement the
# grade-school algorithm if you want, but to get the most out of the assignment
# you'll want to implement recursive integer multiplication and/or Karatsuba's
# algorithm.

# So: what's the product of the following two 64-digit numbers?

# 3141592653589793238462643383279502884197169399375105820974944592
# 2718281828459045235360287471352662497757247093699959574966967627

class Karatsuba
  def self.new(*args, &_blk)
    allocate.send(:calculate, *args)
  end

  def calculate(x, y)
    string_x = x.to_s
    string_y = y.to_s
    length_x = string_x.length
    length_y = string_y.length

    return x * y if length_x == 1 || length_y == 1

    string_y = string_y.rjust(length_x, '0') if length_x > length_y
    string_x = string_x.rjust(length_y, '0') if length_x < length_y

    n = length_x >= length_y ? length_x : length_y
    m = n % 2
    offset = m.zero? ? 0 : 1

    floor = (n / 2.0).floor - offset
    ceil = (n / 2.0).ceil - offset

    a = string_x[0, floor].to_i
    b = string_x[ceil, n].to_i
    c = string_y[0, floor].to_i
    d = string_y[ceil, n].to_i

    (10 ** n) * Karatsuba.new(a, c) +
      (10**(n / 2)) * (Karatsuba.new(a, d) + Karatsuba.new(b, c)) +
      Karatsuba.new(b, d)
  end
end

require 'minitest/autorun'

class TesKaratsuba < MiniTest::Unit::TestCase
  def test_1_by_1_multiplication
    assert_equal 1 * 1, Karatsuba.new(1, 1)
  end

  def test_1_by_0_multiplication
    assert_equal 1 * 0, Karatsuba.new(1, 0)
  end

  def test_1234_by_1234_multiplication
    assert_equal 1234 * 1234, Karatsuba.new(1234, 1234)
  end

  def test_123_by_1234_multiplication
    assert_equal 123 * 1234, Karatsuba.new(123, 1234)
  end

  def test_assignment_calculation
    result = 3141592653589793238462643383279502884197169399375105820974944592 *
             2718281828459045235360287471352662497757247093699959574966967627
    assert_equal(
      result,
      Karatsuba.new(
        3141592653589793238462643383279502884197169399375105820974944592,
        2718281828459045235360287471352662497757247093699959574966967627
      )
    )
  end
end
