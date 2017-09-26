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
  @questions = @survey.questions
  erb(:survey_info)
end

post('/survey/:id') do
  survey_id = params[:id]
  @survey = Survey.find(params["id"].to_i)
  @questions = @survey.questions
  question = params['question']
  @question = Question.new({:question => question, :survey_id => survey_id})
  if @question.save()
    erb(:survey_info)
  else
    erb(:error)
  end
end

delete('/survey/:id') do
  @survey = Survey.find(params['id'].to_i)
  @survey.questions.each { |q| q.delete }
  @survey.delete()
  @surveys = Survey.all()
  redirect('/designer')
end


get('/question/:id') do
  question_id = params[:id]
  @question = Question.find(params["id"].to_i)
  erb(:question_info)
end

delete('/question/:id') do
  @question = Question.find(params['id'].to_i)
  @question.delete()
  @questions = Question.all()
  redirect('/designer')
end
