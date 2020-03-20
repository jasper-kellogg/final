# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :date
  String :location
  String :lat
  String :long

end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going


end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Grocery shopping", 
                    date: "Monday, 23th March",
                    location: "Kellogg Global Hub",
                    lat: "42.0574388",
                    long: "-87.6721363")

events_table.insert(title: "Help in the garden", 
                    date: "Sunday, 22nd March",
                    location: "E2 Evanston",
                    lat: "42.04840850830078",
                    long: "-87.68678283691406")

events_table.insert(title: "Lift to the doctor", 
                    date: "Tuesday, 24th March",
                    location: "Evanston",
                    lat: "42.065773010253906",
                    long: "-87.68450164794922")
