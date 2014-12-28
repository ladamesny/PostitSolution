class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit] 

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    @same_user = same_user?
  end

  def new
    @post = Post.new
    @post.creator = User.first
    @category = Category.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "You created a new post"
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You have updated your post"
      redirect_to post_path(@post)
    else
      render 'posts/edit'
    end
  end

  def vote
    vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|    
      format.html do
        if vote.valid?
          flash[:notice] = "Thanks for your vote!"
        else
          flash[:error] = "You can only vote on a post once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @post.creator
      flash[:error] = "You're not allowed to do that."
      redirect_to posts_path
    end
    
  end

  def same_user?
    if current_user == @post.creator
      true
    else
      false
    end    
  end

end
