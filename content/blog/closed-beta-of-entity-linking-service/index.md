---
title: Closed beta of entity linking service
date: '2014-07-17T23:41:00Z'
lastmod: '2014-07-17T23:47:16Z'
draft: false
author: 178.219.139.186
---

Recently I have deployed an [entity linking](http://en.wikipedia.org/wiki/Entity_linking) service.
It can be found at [klon.wzks.uj.edu.pl/asterion](http://klon.wzks.uj.edu.pl/asterion). So far this is a closed beta - in future I am going to provide
a commercial linking service. If you are interested in testing this service, don't hesitate to [contact me](/kontakt).

The means of operation of the service are simple - you provide a text on input, via HTTP POST and you will receive a JSON response
with names of Wikipedia articles, together with text offsets and confidence values for the proposed links. As with any machine learning
algorithm the output is not perfect, so don't expect "true artificial intelligence" ;-)
Still, the output might be pretty valuable, e.g. for indexing.

The API might be tested as follows (Warsaw is the capital of Poland):

```bash
curl -X POST -d 'text=Warszawa jest stolicą Polski.' http://klon.wzks.uj.edu.pl/asterion/annotator/annotate.json -u 'login:password' -basic
```

The output will look as follows:
```
{[concepts]()
\[
{[id](6605,"name":"Warszawa","confidence":0.21689995068611942,"start":0,"end":7}),
{[id](5664,"name":"Stolica) Polski",[confidence](0.21689995068611942,"start":14,"end":27})
\]
}
```

So far only Polish is supported, but English will be provided soon.
