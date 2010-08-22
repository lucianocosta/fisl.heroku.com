DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost/fisl')
DataMapper::Logger.new(STDOUT, :debug)

class FislApp
    include DataMapper::Resource
    property :id, Serial
    property :name, String, :required => true
    property :url, String, :required => true
    property :password, String, :required => true
    property :description, Text
    property :authors, Text
end

#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!
