class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index
    if params[:theme_id]
      @posts = Post.includes(:user).page(params[:page])
    else
      login_required
      @user = current_user
      @posts = Post.where(:user_id => @user.id).page(params[:page])

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts.to_json(
        :include => { :user => { :only => [:gender, :age, :job] } }
      ) }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    login_required
    @post = Post.new
    @today = Theme.active.first
    p @today
    @user = current_user

    unless @today.nil?
      @already_post = Post.where(:theme_id => @today.id).where(:user_id => @user.id).first
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    login_required
    @user = current_user
    @post =Post.new
    @post.user_id = @user.id
    @post.theme_id = params[:post][:theme_id]
    unless (info = "#{@user.age}#{@user.job}#{@user.gender}").blank?
      @post.body = params[:post][:body] + "(#{info})"
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
