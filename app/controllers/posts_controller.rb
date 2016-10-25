class PostsController < ApplicationController
  before_action :set_current_page, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :show_record_not_found

  # GET /posts
  # GET /posts.json
  def index
      @posts = Post.paginate(page: params[:page], :per_page => 10)
                   .order('title')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = User.find_by username: params[:username]

    respond_to do |format|
      if @post.save
        format.html { redirect_to(post_url(@post, page: @current_page),
                                  notice: 'Post was successful') }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to(post_url(@post, page: @current_page),
                                  notice: 'Post was successfully updated.') }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url(page: @current_page) }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_current_page
    @current_page = params[:page] || 1
  end

  def show_record_not_found(exception)
    respond_to do |format|
      format.html {
        redirect_to(posts_url(page: @current_page),
                    notice: 'Post no longer exists.')
      }
      format.json {
        render json: '{Post no longer exists.}',
               status: :unprocessable_entity
      }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
