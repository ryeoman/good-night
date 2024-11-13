module TimeFormatter
  def self.format(duration)
    seconds = duration % 60
    minutes = (duration / 60) % 60
    hours = duration / 3600

    result = []
    result << "#{hours} #{'hour'.pluralize(hours)}" if hours > 0
    result << "#{minutes} #{'minute'.pluralize(minutes)}" if minutes > 0
    result << "#{seconds} #{'second'.pluralize(seconds)}" if seconds > 0 || result.empty?

    result.join(" ")
  end
end
