require 'csv'
require 'sparkr'

class Lift
  @@datadir = './data'

  def initialize(args = {})
    if args[:data] and File.exist?(args[:data])
      csv_path = args[:data]
    else
      csv = Dir.new('data').entries.select {|file|
        file.match(/\.csv$/) }.first
      csv_path = File.join(@@datadir, csv)
    end
    begin
      @checkins = CSV.read(csv_path).select {|c|
        c[0] != "Id" }.map{|c| LiftCheckin.new :obj => c}
    rescue => e
      "Error: #{e}"
    end
  end

  def checkins
    @checkins
  end

  def parse_habits
    habits = @checkins.inject({}) {|a,c|
      a[c.habit] = [] unless a[c.habit]
      a[c.habit] << c
      a }
    habits.map {|h,checkins|
      habit = LiftHabit.new(:habit => h)
      checkins.each {|c|
        habit.add_checkin(:checkin => c)}
      habit }
  end

  def habits
    habits_count.keys
  end

  def start_date
    checkins.sort_by {|c| c.date}.first.date
  end

  def end_date
    checkins.sort_by {|c| c.date}.last.date
  end

  def week_hash
    start_week = start_date.cweek
    week_h = {}

    (start_date.year..Time.now.year).each do |year|
      (start_week..52).each do |week|
        week = "0#{week}" if week < 10
        week_bucket = "#{year}-#{week}"
        unless Date.strptime(week_bucket, '%Y-%W') > DateTime.now
          week_h.merge!({ 
             week_bucket => 0
          })
        end
      end
      start_week = 1
    end
    week_h
  end
end


class LiftCheckin
  attr_reader :id, 
              :habit, 
              :date, 
              :note, 
              :count, 
              :streak_days,
              :prop_count,
              :comment_count,
              :url

  def initialize(args)
    @id            = args[:obj][0]
    @habit         = args[:obj][1]
    @date          = Date.parse(args[:obj][2])
    @note          = args[:obj][3]
    @count         = args[:obj][4]
    @streak_days   = args[:obj][5]
    @prop_count    = args[:obj][6]
    @comment_count = args[:obj][7]
    @url           = args[:obj][8]
  end
end

class LiftHabit
  attr_reader :name, :checkins

  def initialize(args)
    @name     = args[:habit]
    @checkins = args[:checkins] || []
  end

  def count
    @checkins.count
  end

  def add_checkin(args)
    @checkins << args[:checkin]
  end

  def sparkline(args = {})
    per_week = @checkins.inject(args[:lift].week_hash) {|a,c|
      year_week = c.date.cweek < 10 ? "0#{c.date.cweek}" : c.date.cweek
      week_bucket = "#{c.date.year}-#{year_week}"
      a[week_bucket] = a[week_bucket] + 1
      a
    }
    per_week = Hash[*per_week.sort_by {|k,v| k}.flatten]
    Sparkr.sparkline(per_week.values)
  end
end
