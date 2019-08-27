#!/usr/bin/env ruby

require 'json'
require 'net/http'
require 'open-uri'

# A better approach would be to loop over a smaller page size to get all advisories
# However, NPM allows for a stupid large page size so we'll just use that here
# in the interest of time.
uri = URI.parse("https://www.npmjs.com/advisories?perPage=2000")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Get.new(uri.request_uri)
request['X-Spiferack'] = '1' # https://npm.community/t/can-i-query-npm-for-all-advisory-information/2096

response = http.request(request)
json = JSON.parse(response.body)

# CSV file that will contain all malicious package advisories
advisories = []
advisories << "id,package,affected_versions"

json['advisoriesData']['objects'].each do |advisory|
  if 'Malicious Package'.eql? advisory['title']
    id = advisory['id']
    package = advisory['module_name']
    affected_versions = advisory['vulnerable_versions']

    advisories << "#{id},#{package},#{affected_versions}"
  end
end

out_file = File.new('advisories.csv', 'w')
out_file.puts(advisories)
out_file.close

# puts advisories
