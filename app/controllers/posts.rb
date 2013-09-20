
get '/all_posts' do 
  @posts= Post.all
  erb :all_posts
end

get '/create_post' do
  erb :create
end

get '/post/:id' do
  @this_post = Post.find(params[:id])
  erb :posts
end

get '/post/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

#________________POSTS____________________________________________________________

post '/create_post' do
  name = params[:name]
  content= params[:content]
  tag= params[:tags]
  @post_tags= tag.split("#")
  @new_post = Post.create(name: name, content: content)
  @post_tags.each do |tag|
  @new_tag = Tag.create(name: tag)
  @new_post.tags << @new_tag
  end
  redirect to ("/post/#{@new_post.id}")
end

post '/find_post' do
  @this_post= Post.where(name: params[:name]).first
  if @post
    redirect to ("/post/#{@this_post.id}")
  else
    erb :create
  end
end

post '/posts/:id/delete' do 
  @post = Post.find(params[:id])
  @post.destroy
  redirect to ('/all_posts')
end

post '/post/:id/updated' do
  @post = Post.find(params[:id])
  @post.update_attributes(name: params[:name], content: params[:content])
  redirect to ('/all_posts')
end



