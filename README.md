# API response caching on Rails + Heroku

We all heard this:

> Caching to disk is slow! Let's use memcached.

That is definitely true if application and memcached runs on the same
physical machine. But how does it compare on Heroku? Memcached in this
case runs on a different machine somewhere in the same data center.
That adds some latency. Meanwhile, information pulled from disk fairly
frequently might sit in the disk cache (i.e. RAM). This means that
there's no single simple answer. Let's try to get some numbers then.

Instead of trying to do performance testing on a real applications I
created a [simple setup of 2 Rails apps][3] (you can try reproducing
results if you wish). One is "public facing" (ServiceA). Another -
"internal API" (ServiceB). To serve some responses to a browser
ServiceA makes 3 requests to this "internal API".

```
+---------+     +-----------+      +-----------+
| Browser |     | ServiceA  |      | ServiceB  |
+---------+     +-----------+      +-----------+
     |                |                  |
     | request        |                  |
     |--------------->|                  |
     |                |                  |
     |                | request 1        |
     |                |----------------->|
     |                |                  |
     |                |       response 1 |
     |                |<-----------------|
     |                |                  |
     |                | request n        |
     |                |----------------->|
     |                |                  |
     |                |       response n |
     |                |<-----------------|
     |                |                  |
     |       response |                  |
     |<---------------|                  |
     |                |                  |
```

For baseline numbers I implemented one endpoint which makes those 3
requests without a cache. And just out of curiosity I also added caches
using [Redis][4] and [plain memory][5] store.

We use [Faraday][1] http client together with [Faraday Http Cache][2]
for client side caching.

For load testing I use [Apache JMeter][6].

Things to consider when writing load testing plan:
  * What is average response size?
  * What is approximate number of unique responses?
  * What is approximate request rate? (important when considering disk
  cache - infrequently hit cache will be evicted from RAM)

In my case actual production system response size is 1-3kb,
~300-500 req/min, ~5000 uniques.

## Results

Results taken after warm-up at max throughput and then 2000 samples
of capped 250 req/min throughput. I did not want to overload/saturate
the dyno but rather measure latencies.

Just out of curiosity I started with 100 unique requests:

| Cache type | Average | Median | Deviation |
|------------|---------|--------|-----------|
| No cache   | 95      | 84     | 62        |
| File       | 28      | 24     | 19        |
| Memcached  | 35      | 30     | 25        |
| Memory     | 28      | 23     | 23        |
| Redis      | 34      | 30     | 20        |

Then 1000 unique requests:

| Cache type | Average | Median | Deviation |
|------------|---------|--------|-----------|
| No cache   | 88      | 80     | 41        |
| File       | 28      | 24     | 13        |
| Memcached  | 34      | 30     | 16        |
| Memory     | 28      | 24     | 11        |
| Redis      | 34      | 30     | 16        |

Then 5000 unique requests:

| Cache type | Average | Median | Deviation |
|------------|---------|--------|-----------|
| No cache   |         |        |           |
| File       |         |        |           |
| Memcached  |         |        |           |
| Memory     |         |        |           |
| Redis      |         |        |           |

[1]: https://github.com/lostisland/faraday
[2]: https://github.com/plataformatec/faraday-http-cache
[3]: https://github.com/tadas-s/cache_test
[4]: https://github.com/redis-store/redis-rails
[5]: http://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-memorystore
[6]: http://jmeter.apache.org/
