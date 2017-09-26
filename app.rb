require 'sinatra/activerecord'
require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload'.lib/**/*.rb'
require './lib/survey'
require './lib/question'
require 'pg'

get('/') do
  redirect '/designer'
end

get('/designer') do
  @surveys = Survey.all()
  @questions = Question.all()
  erb(:designer)
end

post('/designer') do
  survey = params['survey']
  @survey = Survey.new({:survey => survey})
  @surveys = Survey.all
  if @survey.save()
    erb(:designer)
  else
    erb(:error)
  end
end

get('/survey/:id') do
  survey_id = params[:id]
  @survey = Survey.find(params["id"].to_i)
  erb(:survey_info)
end
