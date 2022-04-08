class PostsController < ApplicationController
  
  before_action :require_login

  def index
    run Post::Operation::Index do |result|
      @posts = result[:posts].paginate(:page=>params[:page],per_page: 5)
    end
  end

  def show
    run Post::Operation::Edit
    @post = result["model"]
  end

  def edit
    run Post::Operation::Edit
    @post = result["model"]
  end

  def new
    @form = Post.new
  end

  def create
    run Post::Operation::Create, current_user: current_user do |result|
      return redirect_to root_path,notice: "Post is saved successfully!"
    end
    render :new
  end

  def update
    if params[:post]
      puts (params[:post])
    else 
      params[:post] = params[:post_contract_update]
    end
    _ctx = run Post::Operation::Update, current_user: current_user  do |result|
      return redirect_to posts_show_path('id'=>params[:post][:id]), notice: "Post updated successfully!"
    end
    @post   = _ctx["contract.default"]
    @title  = "Editing #{_ctx[:model].title}"
    @description  = "Editing #{_ctx[:model].description}"
    render :edit
  end

  def destroy
    run Post::Operation::Destroy do |_|
      return redirect_to root_path, notice: "Post deleted successfully!"
    end 
  end

  def search_post
    @searchKey = params[:searchInfo]
    run Post::Operation::Search do |result|
      @posts = result[:posts].paginate(:page=>params[:page],per_page: 5)
      render :index
      return
    end
  end

  def export_csv
    run Post::Operation::Index do |result|
      @posts = result[:posts]
    end
    respond_to do |format|
      format.html
      format.csv {send_data @posts.to_csv, filename:"posts-#{Date.today}.csv"}
    end
  end

  def import_csv
    run Post::Operation::Import, current_user_id: current_user.id do |_|
      return redirect_to root_path,  notice: "CSV for posts is successfully uploaded."
    end
  end

end
