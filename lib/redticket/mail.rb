# -*- coding: utf-8 -*-
class Redticket::Mail
  def initialize
    @text = ""
    @text << header
    @text << body
  end

  def to_s
    @text
  end

  private
  def header
    return <<EOT
From: #{Redticket::CONFIG.from_address}
To: #{to}
Subject: #{Redticket::CONFIG.subject}
Date: #{Time::now.strftime("%a, %d %b %Y %X %z")}
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

EOT
  end

  def body
    return <<EOT
#{Redticket::CONFIG.body}

#{keywords}
EOT
  end

  def to
    [Redticket::CONFIG.to_address].flatten.compact.join(",\n ")
  end

  def keywords
    keywords = %w(project tracker status priority category assigned_to
                  fixed_version start_date due_date
                  estimated_hours done_ratio)
    humanize_keywords = ["Project", "Tracker", "Status", "Priority", "Category", "Assigned to",
                         "Fixed version", "Start date", "Due date",
                         "Estimated hours", "Done ratio"]
    keywords.zip(humanize_keywords).map do |k, kh|
      "#{kh}: #{Redticket::CONFIG.send(k)}" if Redticket::CONFIG.send(k)
    end.compact.join("\n")
  end
end
