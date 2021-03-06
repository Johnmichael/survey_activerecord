require 'sinatra/activerecord'
require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload'.lib/**/*.rb'
require './lib/survey'
require './lib/question'
require './lib/answer'
require 'pg'

get('/') do
erb(:index)
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
  @answers = Answer.all()
  erb(:question_info)
end

post('/question/:id') do
  @question = Question.find(params["id"].to_i)
  answer_id = params[:id]
  answer = params['answer']
  @answers = Answer.all()
  @answer = Answer.new({:answer => answer, :question_id => answer_id})
  if @answer.save()
    erb(:question_info)
  else
    erb(:error)
  end
end

delete('/question/:id') do
  @question = Question.find(params['id'].to_i)
  @question.delete()
  @questions = Question.all()
  redirect('/designer')
end

get('/taker') do
  @surveys = Survey.all()
  erb(:taker)
end

post('/taker') do
  @surveys = Survey.all
  survey = params['survey']
  
  binding.pry
  erb(:taker)
end
