class TodoController < Sinatra::Base
  get "/hello" do
    "Welcome to TodoController"
  end

  post "/todos/create" do
    data = JSON.parse(request.body.read)
    # data.to_s

    #approach 1 (individual columns)
    begin
      today = Time.now
      #     title = data["title"]
      #     description = data["description"]
      #     todo = Todo.create(title: title, description: description, createdAt: today)
      #     todo.to_json

      #approach 2 (hash of columns)
      data["createdAt"] = today
      todo = Todo.create(data)
      [201, todo.to_json]
    rescue => e
      [422,
          {
              error: "Anerror occurred while updating ToDO",
            }.to_json]
    end
  end

  get '/todos' do
    todos = Todo.all
    [200, todos.to_json]
  end


  put '/todos/update/:id' do
    begin
    data = JSON.parse(request.body.read)
    todo_id = params['id'].to_i
    todo = Todo.find(todo_id)
    todo.update(data)
    {message: 'Done King'}.to_json
  rescue => e
    [422, {error: e.message}.to_json]
  end
  end

  delete '/todos/destroy/:id' do
        begin
            todo_id = params['id'].to_i
            todo = Todo.find(todo_id)
            todo.destroy
            {message: 'Toxic goat'}.to_json
            rescue => e
             [422, {error: e.message}.to_json]

        end
    end

end
