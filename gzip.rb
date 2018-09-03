require 'sinatra'
require 'zlib'
require 'pry'
get '/' do
  tags = Array.new 1024 do
    tag = %w[div b span p h1 h2 h3 h4 h5 i].sample
    "<#{tag}>#{methods.sample}</#{tag}>"
  end
  html = tags.join "\n"
  return html unless env['HTTP_ACCEPT_ENCODING']&.include? 'gzip'
  headers['Content-Encoding'] = :gzip
  compressed = Zlib.gzip html
  puts "#{html.size}->#{compressed.size} #{compressed.size.fdiv html.size}"
  compressed # must cache it!
end
