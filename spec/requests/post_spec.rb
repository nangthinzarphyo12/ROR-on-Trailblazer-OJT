require "rails_helper"

RSpec.describe "Post", :type => :request do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }
  let(:post_params) {
    {
      title: "800 bowl",
      description: "chinese noolde",
      public_flag: true,
      created_by: 3,
    }
  }

  let(:update_post_params) {
    {
      title: "drinks",
      description: "fruit",
      public_flag: true,
      created_by: 3,
    }
  }

  let(:invalid_update_post_params) {
    {
      title: "",
      description: "",
    }
  }

  let(:post_invalid_params) {
    {
      title: "",
      description: "",
      public_flag: 1,
      updated_by: 3,
    }
  }

  # post index
  describe "/posts/index" do
    scenario "get post list" do
      get "/posts/index"
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

   # post new
   describe "/posts/new" do
    scenario "get post list" do
      get "/posts/new"
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  # post create
  describe "/posts/new" do
    scenario "post create with valid params" do
      post "/posts/new", params: { :post => post_params }
      post = Post.last
      expect(post.title).to eq("800 bowl")
      expect(post.description).to eq("chinese noolde")
    end

    scenario "post create with invalid params" do
      post "/posts/new", params: { :post => post_invalid_params }
      expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
      expect(assigns(:form).errors[:description][0]).to eq "can't be blank"
      expect(response).to render_template(:new)
    end
  end

  # post detail
  describe "/posts/show" do
    scenario "post detail" do
      post = Post.last
      get posts_show_path(:id => post.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end

  # post edit page
  describe "/posts/edit" do
    scenario "post edit" do
      post = Post.last
      get posts_edit_path(:id => post.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
  end

  # post update
  describe "/posts/edit" do
    scenario "update post with valid params" do
      last_post_id = Post.last.id
      update_post_params[:id] = last_post_id
      patch "/posts/edit/", params: { post: update_post_params , id: last_post_id}
      updated_post = Post.find_by(id: last_post_id)
      expect(updated_post.title).to eq("drinks")
    end

    scenario "update post with invalid params" do
      last_post_id = Post.last.id
      invalid_update_post_params[:id] = last_post_id
      patch "/posts/edit/", params: { post_contract_update: invalid_update_post_params , id: last_post_id}
      updated_post = Post.find_by(id: last_post_id)
      expect(updated_post.title).not_to eq("drinks")
      expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
      expect(response).to render_template(:edit)
    end
  end

  # post delete
  describe "posts/destroy" do
    scenario "delete post" do
      initial_post_count = Post.count
      post = Post.create! post_params
      get "/posts/destroy", params: { :id => post.id }
      final_post_count = Post.count
      expect(final_post_count - initial_post_count).to eq(0)
      expect(flash[:notice]).to eq('Post deleted successfully!')
    end
  end

  # post search
  describe "posts/search" do
    scenario "search post" do
      get "/posts/search", params: { :searchInfo => 'post' }
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # export csv
  describe "post/export" do
    scenario 'csv export' do
      Post.create! post_params
      get "/posts/export", params: {format: 'csv'}
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.body).to include('800 bowl')
    end
  end

  # import csv
  describe "posts/import" do
    scenario "import csv" do
      initial_post_count = Post.count
      post "/posts/import",params: { :file => Rack::Test::UploadedFile.new("#{Rails.root}/tmp/rspec/posts.csv", 'text/csv') }
      post = Post.last
      final_post_count = Post.count
      expect(final_post_count - initial_post_count).to eq(1)
      expect(post.title).to eq("post csv import test")
      expect(flash[:notice]).to eq('CSV for posts is successfully uploaded.')
    end
  end

end
