# require_relative 'config/application'

get '/' do
  @notes = Task.all #:order => :id.desc
  @title = 'All Notes'
  erb :home
end

post '/' do
  n = Task.create({:content => params[:content], :complete => false})
  redirect '/'
end

get '/:id' do
  @note = Task.find(params[:id])
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

put '/:id' do
  n = Task.find(params[:id])
  n.content = params[:content]
  n.complete = params[:complete] ? 1 : 0
  n.save
  redirect '/'
end

get '/:id/delete' do
  @note = Task.find(params[:id])
  @title = "Confirm deletion of note ##{params[:id]}"
  erb :delete
end

delete '/:id' do
  Task.destroy(params[:id])
  redirect '/'
end

get '/:id/complete' do
  n = Task.find(params[:id])
  n.complete = n.complete ? 0 : 1 #flip the state
  n.save
  redirect '/'
end























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




