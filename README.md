# npm-advisory-scraper

Scraper for NPM malicious package advisories. To run:

```sh
$ ./npm-advisory-scraper.rb
```

This will write out a CSV called advisories.csv that contain information on all of the malicious package NPM advisories.

Note that this script currently hits https://www.npmjs.com/advisories with a really large perPage count. This is really hacky and it should be re-written to page through the advisories with a smaller perPage count.
