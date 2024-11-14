require "test_helper"

class TimeFormatterTest < Minitest::Test
  def test_format_seconds_only
    assert_equal "45 seconds", TimeFormatter.format(45)
  end

  def test_format_minutes_and_seconds
    assert_equal "1 minute 30 seconds", TimeFormatter.format(90)
  end

  def test_format_hours_minutes_and_seconds
    assert_equal "1 hour 1 minute 1 second", TimeFormatter.format(3661)
  end

  def test_format_hours_only
    assert_equal "2 hours", TimeFormatter.format(7200)
  end

  def test_format_minutes_only
    assert_equal "5 minutes", TimeFormatter.format(300)
  end

  def test_format_zero_seconds
    assert_equal "0 seconds", TimeFormatter.format(0)
  end
end
