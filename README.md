# liftcsv

as of the latest commit, this is just a library. I've been using it with pry, like so:

```
gwilliamac :: ~/src/lift-app ‹master› % pry -Ilib -rlift -e 'l = Lift.new; nil'
[2] pry(main)> puts l.parse_habits.map {|h| "#{h.sparkline(:lift => l)} :: #{h.name} (#{h.count})"}
```

I'll be adding a `bin/lift` tool shortly. Even a `rake` task would probably be more than sufficient at this point.
