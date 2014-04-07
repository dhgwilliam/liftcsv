# liftcsv

![](http://cl.ly/image/2g062R1l0f1c/Screen%20Shot%202014-04-05%20at%2010.32.17%20PM.png)

usage
---

as of the latest commit, this is just a library. I've been using it with pry, like so:

```
gwilliamac :: ~/src/lift-app ‹master› % pry -Ilib -rlift -e 'l = Lift.new; nil'
[2] pry(main)> puts l.parse_habits.map {|h| "#{h.sparkline(:lift => l)} :: #{h.name} (#{h.count})"}
```

I'll be adding a `bin/lift` tool shortly. Even a `rake` task would probably be more than sufficient at this point.


setup
---

1. `bundle install`
2. export your lift data as csv: <https://lift.do/users/export_csv>
2. drop your [lift.do](https://lift.do) csv in the data directory
    - as of right now, the lib expects exactly one csv in the data dir
3. see [usage](#usage)


todo
---

- add `bin/lift` tool for interacting with lib
- package as gem
- allow user to specify location of csv
