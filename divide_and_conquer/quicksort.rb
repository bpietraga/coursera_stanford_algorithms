class QuickSortCounter
  def self.new(*args, &_blk)
    allocate.send(:calculate, *args)
  end

  private

  def calculate(arr, flag)
    @arr   = arr
    @flag  = flag
    @count = 0

    sort(0, @arr.length - 1)
  end

  # Sorting function, returning count of inversions.
  def sort(i, j)
    return 0 if (j - i) < 1

    @count += j - i
    swap(i, [i, j, (i + j) / 2].sort_by { |x| @arr[x] }[1]) if @flag == 1
    swap(i, j)                                              if @flag == 2

    @sm_i = i + 1
    (i + 1 .. j).each { |p| (swap(@sm_i, p); @sm_i += 1) if @arr[p] < @arr[i] }
    p = @sm_i - 1
    swap(i, p)

    sort(i, p - 1)
    sort(p + 1, j)

    @count
  end

  # Swap indices in array.
  def swap(i, j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end
end

require 'minitest/autorun'

class TestQuickSortCounter < MiniTest::Unit::TestCase
  ARRAY = IO.foreach('QuickSort.txt').map(&:strip).map(&:to_i).freeze

  def test_pivot_at_the_beggining_of_array
    assert_equal 162085, QuickSortCounter.new(ARRAY.dup, 0)
  end

  def test_pivot_at_the_median_of_array
    assert_equal 138382, QuickSortCounter.new(ARRAY.dup, 1)
  end

  def test_pivot_at_the_end_of_array
    assert_equal 164123, QuickSortCounter.new(ARRAY.dup, 2)
  end
end
