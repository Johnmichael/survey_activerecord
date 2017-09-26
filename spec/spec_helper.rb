ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("sinatra/activerecord")
require("division")
require("employee")
require("project")

RSpec.configure do |config|
  config.after(:each) do
    Survey.all().each() do |survey|
      survey.destroy()
    end
    Question.all().each() do |question|
      question.destroy()
    end
  end
end
