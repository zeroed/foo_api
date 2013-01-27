# WIKI_FOO Api

Just having fun with ruby, grape gem and Wikipedia... with a flavour of REST and JSON

`http://localhost:5000/wiki/<page_title>`

---

## What is Grape?

![grape logo](https://github.com/intridea/grape/wiki/grape_logo.png)

Grape is a REST-like API micro-framework for Ruby. It's designed to run on Rack
or complement existing web application frameworks such as Rails and Sinatra by
providing a simple DSL to easily develop RESTful APIs. It has built-in support
for common conventions, including multiple formats, subdomain/prefix restriction,
content negotiation, versioning and much more.

[grape@github](https://github.com/intridea/grape)

# MEDIAWIKI::API

![mediawiki logo](http://upload.wikimedia.org/wikipedia/commons/1/1c/MediaWiki_logo.png)

[mediawiki API](http://www.mediawiki.org/wiki/API:Main_page)

formats: 

* JSON/YAML
  `api.php ? action=query & titles=Albert%20Einstein & prop=info & format=jsonfm`
* XML
  `api.php ? action=query & titles=Albert%20Einstein & prop=info & format=xmlfm`

`http://en.wikipedia.org/w/api.php?format=xml&action=query&titles=Main%20Page&prop=revisions&rvprop=content`
