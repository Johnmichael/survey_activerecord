require 'sinatra/activerecord'
require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload'.lib/**/*.rb'
require './lib/survey'
require './lib/question'
require 'pg'

get('/designer') do
  @surveys = Survey.all()
  @questions = Question.all()
  erb(:designer)
end

post('/designer') do
  survey = params['survey']
  @survey = Survey.create(:survey => survey)
  @surveys = Survey.all
  erb(:designer)
end

get('/survey/:id') do
  survey_id = params[:id]
  @survey = Survey.find(params["id"].to_i)
  erb(:survey_info)
end
