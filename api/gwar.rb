require 'grape'
require 'warden'

module GWAR
  class API < Grape::API
    format :json

    SurvivalItem = Struct.new(:name, :weight, :value)

    desc "get the proper survival pack"
    #content-type "text/plain"
    ## This takes care of parameter validation
    params do
      #requires :maxwt, type: Integer
      #requires :itemsdict, type: JSON 
      requires type: JSON
    end
    ## This takes care of creating pack
    ## Have to write some more code here to handle knapsack
    post do
      ## here are method definitions to manage parameters
      #{"answer" => params[:maxwt],"items" => params[:items]} # this gets the right data from the curl request!
      {"survival-pack" => params}
    end
    #end

    # basic get works here
    get "testroute" do
      def self.return_thing()
        {"answer" => "hahaha oh yeah"}
      end
      self.return_thing()
    end



    # authentication
    get "warden" do
      env['warden'].authenticate!
      { "status_code" => 200, "status_text" => "Authorized"}
    end

    get "info" do
        env['warden'].authenticate!
        env['warden'].user.name
    end

    get 'unauthenticated' do
        { "status_code" => 401, "status_text" => "Unauthorized"}
    end

    post 'login' do
        env['warden'].authenticate(:password)
    end
  end

  # borrowed class User
  class User
    attr_reader :name
    attr_reader :id
    def initialize(name)
        @name = name
        @id = 2015
    end

    def self.get(id)
        return User.new('jackie')
    end

    def self.authenticate(u, p)
        return User.new('jackie')
    end
  end
end
