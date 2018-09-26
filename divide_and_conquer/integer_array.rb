# `This file contains all of the 100,000 integers between 1 and 100,000`
# (inclusive) in some order, with no integer repeated.

# Your task is to compute the number of inversions in the file given, where the
# i th row of the file indicates the i th entry of an array.

# Because of the large size of this array, you should implement the fast
# divide-and-conquer algorithm covered in the video lectures.

# The numeric answer for the given input file should be typed in the space
# below.

# So if your answer is 1198233847, then just type 1198233847 in the space
# provided without any space / commas / any other punctuation marks. You can
# make up to 5 attempts, and we'll use the best one for grading.

# (We do not require you to submit your code, so feel free to use any
# programming language you want --- just type the final numeric answer in the
# following space.)

# [TIP: before submitting, first test the correctness of your program on some
# small test files or your own devising. Then post your best test cases to the
# discussion forums to help your fellow students!]

class InversionCount
  def initialize(array)
    @array = array
    @inversions = 0
  end

  def call
    count_inversions(@array)
    @inversions
  end

  private

  def count_inversions(array)
    return array if array.length <= 1

    left  = array.slice(0, array.length / 2)
    right = array - left
    merge_results(count_inversions(left), count_inversions(right))
  end

  # This is iterative approach to the problem.
  # The recursive one was causing Ruby stack overflow.
  def merge_results(left, right)
    a = []
    loop do
      if left.first < right.first
        a << left.shift
      else
        @inversions += left.length
        a << right.shift
      end
      break if left.empty? || right.empty?
    end

    a + left + right
  end
end

require 'minitest/autorun'

class TestInversionCount < MiniTest::Unit::TestCase
  # This test case opens the Coursera provided file and transfroms the content
  # to array of integers.
  def test_assignment_calculation
    array = IO.foreach('IntegerArray.txt').map(&:strip).map(&:to_i)
    assert_equal 2407905288, InversionCount.new(array).call
  end

  def test_with_sorted_array
    array = [1,2,3,4,5,6]
    assert_equal 0, InversionCount.new(array).call
  end

  def test_with_inverted_array
    array = [6,5,4,3,2,1]
    assert_equal 15, InversionCount.new(array).call
  end
end
