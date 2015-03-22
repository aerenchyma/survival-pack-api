require File.join(File.dirname(__FILE__), 'api', 'survivalpack')

if ENV['RACK_ENV'] == 'development'

end

use Rack::Session::Cookie, :secret => "abcdefg"

run SurvivalPack::API
