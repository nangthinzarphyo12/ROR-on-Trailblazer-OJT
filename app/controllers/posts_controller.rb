class PostsController < ApplicationController
  
  before_action :require_login

  def index
    allpost = PostService.getAllPosts
    @posts= allpost.paginate(:page=>params[:page],per_page: 5)
  end

  def show
    @post = PostService.getPostByID(params[:id])
  end

  def edit
    @post = PostService.getPostByID(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post[:created_by] = session[:id]
    post = PostService.insertPost(@post)
    if post
      redirect_to root_path, notice: "Post created successfully!"
    else
      render :new 
    end
  end

  def update
    @post = PostService.getPostByID(post_params[:id])
    @post.updated_by = session[:id]
    isUpdated = PostService.updatePost(post_params,@post)
    if isUpdated  
      redirect_to posts_show_path('id'=>post_params[:id]), notice: "Post updated successfully!"
    else
      render :edit
    end 
  end

  def destroy
    isDeleted = PostService.deletePost(params[:id])  
    if isDeleted 
      redirect_to root_path, notice: "Post deleted successfully!"
    else
      render :destroy
    end   
  end

  def search_post
        @searchKey = params[:searchInfo]
        @posts = PostService.searchPost(@searchKey).paginate(:page=>params[:page],per_page: 5)
        render :index
  end

  def export_csv
    @posts = PostService.getAllPosts
    respond_to do |format|
      format.html
      format.csv {send_data @posts.to_csv, filename:"posts-#{Date.today}.csv"}
    end
  end

  def import_csv
    created_id = session[:id]
    
    if params[:file].blank?
      redirect_to root_path, alert: "Please choose file to import."
    elsif !File.extname(params[:file]).eql?(".csv")
      redirect_to root_path, alert: "Please choose CSV file only to import."
    else 
      error_msg = header_check(params[:file])
      if error_msg.present?
        redirect_to root_path, alert: error_msg
      elsif
        error_msg = record_check(params[:file])
        if error_msg.present?
          redirect_to root_path, alert: error_msg.first
        else
          isUploaded = Post.import(params[:file],created_id)
          redirect_to root_path, notice: "CSV for posts is successfully uploaded."
        end
      end
    end
  end

  def header_check(file)
    header_in_csv = CSV.open(file, 'r') { |csv| csv.first }
    valid_header = %w{title description public_flag}
    if header_in_csv.size > valid_header.size
      error_msg = "More than valid column number."
    else
      x = 0
      while x < header_in_csv.size
        if header_in_csv[x] != valid_header[x]
          error_msg = "Some columns name are invalid.Please check again."
        end
        x += 1
      end
    end
    return error_msg
  end

  def record_check(file)
    error_msg = []
    total_column = 3
    i = 0
    while i < total_column
    col_data = []
    CSV.foreach(file,headers:true) {|row| col_data << row[i]}
    k = 0
      total_row = col_data.size
      while k < total_row
        if i == 0
          if col_data[k].blank?
            error_msg.append("title for row ("+(k+1).to_s+") cannot be blank.")
          elsif col_data[k].size > 255
            error_msg.append("title for row("+(k+1).to_s+") is too long (maximum is 255 characters)")
          end
        elsif i == 1
          if col_data[k].blank?
            error_msg.append("description for row ("+(k+1).to_s+") cannot be blank.")
          elsif col_data[k].size > 1000
            error_msg.append("description for row ("+(k+1).to_s+") is too long (maximum is 1000 characters)")
          end
        else
          if col_data[k].blank?
            error_msg.append("public flag for row ("+(k+1).to_s+") cannot be blank.")
          elsif col_data[k].size > 1
            error_msg.append("public flag for row ("+(k+1).to_s+") is too long (maximum is 1 characters)")
          end
        end
        k += 1
      end
      i += 1
    end
    return error_msg
  end

  private
  def post_params
    params.require(:post).permit(:id ,:title ,:description ,:public_flag ,:created_by ,:updated_by)
  end

end
