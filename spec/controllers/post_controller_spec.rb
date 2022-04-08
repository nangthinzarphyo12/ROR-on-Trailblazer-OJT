require "rails_helper"

RSpec.describe PostsController, type: :controller do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }

  let(:post_params) {
    {
      title: "title1",
      description: "des1",
      public_flag: 1,
      created_by: 3,
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

  describe "GET posts#index" do
    it "get post list" do
      post = Post.create
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # function :new
  describe "GET posts#new" do
    it "get create page" do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  # function :create
  describe "GET posts#create" do
    it "create post with valid params" do
      post :create, params: { :post => post_params }
      post = Post.last
      expect(post.title).to eq('title1')
      expect(response).to redirect_to(root_path)
    end

    it "create post with invalid params" do
      post :create, params: { :post => post_invalid_params }
      expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
      expect(assigns(:form).errors[:description][0]).to eq "can't be blank"
      expect(response).to render_template(:new)
    end
  end

  # function :show
  describe "GET posts#show" do
    it "show post detail" do
      last_post = Post.last
      get :show, params: { :id => last_post.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end

  # function :edit
  describe "GET posts#edit" do
    it "show post edit" do
      last_post = Post.last
      get :edit, params: { :id => last_post.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
  end

  # function :update
  describe "GET posts#update" do
    context "valid post update" do
      it "update post with valid params" do
        last_post = Post.last
        put :update, params: { :post => post_params, :id => last_post.id }
        expect(assigns(:model).title).to eq "title1"
      end
      it "update post with invalid params" do
        last_post = Post.last
        put :update, params: { :post_contract_update => post_invalid_params, :id => last_post.id }
        expect(assigns(:form).errors[:title][0]).to eq "can't be blank"
        expect(response).to render_template(:edit)
      end
    end
  end

  # function :destroy
  describe "GET posts#destroy" do
    it "delete post" do
      initial_post_count = Post.count
      post = Post.create! post_params
      delete :destroy, params: { :id => post.id }
      final_post_count = Post.count
      expect(final_post_count - initial_post_count).to eq(0)
      expect(flash[:notice]).to eq('Post deleted successfully!')
      expect(response).to redirect_to(root_path)

    end
  end

  # function :search
  describe "GET posts#search_post" do
    it "post search" do
      get :search_post, params: { searchInfo: "post" }
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # functiton :csv_export
  describe "GET posts#export_csv" do
    it 'csv export' do
      Post.create! post_params
      get :export_csv, format: :csv
      expect(response.header['Content-Type']).to include 'text/csv'
      expect(response.body).to include('post7')
    end
  end

  # function import csv
  describe "GET posts#import_csv" do
    it "import csv" do
      initial_post_count = Post.count
      post :import_csv, params: { :file => fixture_file_upload("#{Rails.root}/tmp/rspec/posts.csv", "text/csv") }
      post = Post.last
      final_post_count = Post.count
      expect(final_post_count - initial_post_count).to eq(1)
      expect(post.title).to eq("post csv import test")
      expect(flash[:notice]).to eq('CSV for posts is successfully uploaded.')
    end
  end
end
