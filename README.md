# liftcsv

![](http://cl.ly/image/2g062R1l0f1c/Screen%20Shot%202014-04-05%20at%2010.32.17%20PM.png)

usage
---

until I turn this into a gem, you can use the `bin/liftcsv` client like so:

```
ruby -Ilib bin/liftcsv --data path/to/lift.csv
```


setup
---

1. `bundle install`
2. export your lift data as csv: <https://lift.do/users/export_csv>
2. either specify the location of your data file from the CLI 
(see [usage](#usage)) or drop your [lift.do](https://lift.do) csv in the data directory
    - as of right now, the lib expects exactly one csv in the data dir
3. see [usage](#usage)


todo
---

- package as gem
