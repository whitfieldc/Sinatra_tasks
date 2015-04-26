require 'pathname'
require 'sqlite3'
require 'active_record'
require 'logger'
require 'sinatra'

APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))

APP_NAME = APP_ROOT.basename.to_s

DB_PATH  = APP_ROOT.join('db', APP_NAME + ".db").to_s

if ENV['DEBUG']
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Automatically load every file in APP_ROOT/app/models/*.rb, e.g.,
#   autoload "Person", 'app/models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => DB_PATH
require_relative 'controllers/todo_control'

# get '/' do
#   @notes = Task.all :order => :id.desc
#   @title = 'All Notes'
#   erb :home
# end

# post '/' do
#   n = Task.create({:content => params[:content], :complete => false})
#   redirect '/'
# end

# get '/:id' do
#   @note = Task.find(params[:id])
#   @title = "Edit note ##{params[:id]}"
#   erb :edit
# end

# put '/:id' do
#   n = Task.find(params[:id])
#   n.content = params[:content]
#   n.complete = params[:complete] ? 1 : 0
#   n.save
#   redirect '/'
# end

# get '/:id/delete' do
#   @note = Task.find(params[:id])
#   @title = "Confirm deletion of note ##{params[:id]}"
#   erb :delete
# end

# delete '/:id' do
#   Task.destroy(params[:id])
#   redirect '/'
# end

# get '/:id/complete' do
#   n = Task.find(params[:id])
#   n.complete = n.complete ? 0 : 1 #flip the state
#   n.save
#   redirect '/'
# end























################## Leftover from ARGV DBC prompt
# puts "Put your application code in #{File.expand_path(__FILE__)}"

# input = ARGV.dup

# command = input.shift

# desc = input.join(" ")

# task_id = desc.to_i

# case command
#   when "list"
#     task_set = Task.all
#     task_set.each do |task|
#       task.complete ? completeness = "X" : completeness = " "
#       p "[#{completeness}] " + task.id.to_s + " - " + task.description
#     end
#   when "add"
#     new_task  = {description: desc, complete: false }
#     Task.create(new_task)
#     p "Task added."
#   when "delete"
#     Task.destroy(task_id)
#     p "Task deleted."
#   when "complete"
#     target_task = Task.find(task_id)
#     target_task.complete = true
#     target_task.save
#     p "Task marked as complete"
# end




