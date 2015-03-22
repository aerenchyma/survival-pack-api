require 'grape'
require 'warden'

module GWAR
  class API < Grape::API
    format :json

    desc "get the proper survival pack"
    #content-type "text/plain"
    ## This takes care of parameter validation
    params do
      requires type: JSON # expects properly formatted JSON data
    end
    ## Have to write some more code here to handle knapsack
    post do
      ## here are method definitions to manage parameters
      #SurvivalItem = Struct.new(:name, :weight, :value)

      # find items already in pack
      def self.find_used_items(items, values_overall)
        itm = values_overall.length - 1
        currVal = values_overall[0].length - 1
        checked = values_overall.map{0}

        while (itm >= 0 && currVal >= 0)
          if (itm == 0 && values_overall[itm][currVal] > 0) || (values_overall[itm][currVal] != values_overall[itm-1][currVal])
            checked[itm] = 1
            currVal -= items[itm][1]
          end
          itm -= 1
        end
        checked # the items that have been used -- i.e. put into the surival pack
      end

      # method to make a text list of the items that are used for display/testing
      def self.list_of_used_items_names(items,already_used)
        items.zip(already_used).map{|item,used| item[0] if used > 0}.compact.join(', ')
      end

      # method to solve the knapsack problem using those methods, given items and max. wt
      def self.survival_pack(items, maxwt)
        items_amount = items.size
        # create matrix for value
        values_overall = Array.new(items_amount){Array.new(maxwt+1,0)}

        items_amount.times do |i|
          (maxwt + 1).times do |j|
            if (items[i][1] > j)
              values_overall[i][j] = values_overall[i-1][j]
            else
              values_overall[i][j] = [values_overall[i-1][j],items[i][2] + values_overall[i-1][j-items[i][1]]].max
            end
          end
        end
        already_used = find_used_items(items, values_overall)
        # all names, total weight, total value, for end pack result
        result = [list_of_used_items_names(items,already_used),items.zip(already_used).map{|item,used| item[1]*used}.inject(:+),values_overall.last.last]
        {:pack_items => result[0], :total_weight => result[1], :total_value => result[2]}.to_json
      end

      # method to manage input and output data
      def self.manage_input_data(json_arr)
        # should accept json-formatted hash
        items =[]
        maxwt = json_arr["maxwt"]
        item_dicts = json_arr["data"]["items"]
        item_dicts.each_key do |namewtval|
          # namewtval is each key (item name) in the items dictionary
          # that's how you access each item's weight, value
          items.push([namewtval,item_dicts[namewtval]["weight"],item_dicts[namewtval]["value"]])
        #puts items # for testing
        end
        survival_pack(items,maxwt) # returns json response
      end

      answer = self.manage_input_data(params)
      {"survival-pack" => answer}
    end
    #end

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
