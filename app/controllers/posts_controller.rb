class PostsController < ApplicationController
  before_filter {
    login_required
  }

  # GET /posts
  # GET /posts.json
  def index
    @user = current_user
    @posts = Post.where(:user_id => @user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @today = Theme.today
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @post =Post.new
    @post.user_id = @user.id
    @post.theme_id = params[:post][:theme_id]
    @post.body = params[:post][:body]

    p @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
