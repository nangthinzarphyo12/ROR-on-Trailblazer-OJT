require "rails_helper"

RSpec.describe "User", :type => :request do
  before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user) }
  let(:user_params) {
    {
      name: "Nang",
      email: "nang@gmail.com",
      password: '123456',
      password_confirmation: '123456',
      role: 1
    }
  }

  let(:update_user_params) {
    {
        name: "Everlynn",
        email: "everlynn@gmail.com"
    }
  }

  let(:invalid_user_params) {
    {
      name: "",
      email: "",
    }
  }

  let(:valid_password_params) {
    {
      password: "123update",
      password_confirmation: "123update",
    }
  }

  let(:invalid_password_params) {
    {
      password: "",
      password_confirmation: "",
    }
  }

  # user index
  describe "/users/list" do
    scenario "get user list" do
      get "/users/list"
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # user new
  describe "/users/new" do
    scenario "get user new page" do
      get "/users/new"
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  # user create
  describe "/users/new" do
    scenario "user create with valid params" do
      post "/users/new", params: { :user => user_params }
      user = User.last
      expect(user.name).to eq("Nang")
      expect(user.email).to eq("nang@gmail.com")
    end

    scenario "user create with invalid params" do
      post "/users/new", params: { :user => invalid_user_params }
      expect(assigns(:form).errors[:name][0]).to eq "can't be blank"
      expect(response).to render_template(:new)
    end

  end

  # user detail
  describe "/users/show" do
    scenario "user detail" do
      user = User.last
      get users_show_path(:id => user.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end
  end

  # user edit page
  describe "/users/edit" do
    scenario "user edit" do
      user = User.last
      get users_edit_path(:id => user.id)
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end
  end

  # user update
  describe "/users/edit" do
    scenario "update user with valid params" do
      last_user_id = User.last.id
      update_user_params[:id] = last_user_id
      patch "/users/edit/", params: { user: update_user_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      expect(updated_user.name).to eq("Everlynn")
    end

    scenario "update user with invalid params" do
      last_user_id = User.last.id
      invalid_user_params[:id] = last_user_id
      patch "/users/edit/", params: { user_contract_update: invalid_user_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      expect(updated_user.name).not_to eq("Everlynn")
      expect(assigns(:form).errors[:name][0]).to eq "can't be blank"
      expect(response).to render_template(:edit)
    end
  end

  # user delete
  describe "users/destroy" do
    scenario "delete user" do
      initial_post_count = User.count
      user = User.create! user_params
      get "/users/destroy", params: { :id => user.id }
      final_post_count = User.count
      expect(final_post_count - initial_post_count).to eq(0)
      expect(flash[:notice]).to eq('User deleted successfully!')
    end
  end

   # user search
   describe "users/search" do
    scenario "search user" do
      get "/users/search", params: { :searchInfo => 'admin' }
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
  end

  # user profile show
  describe "/users/profile" do
    scenario "user profile" do
      user = User.last
      get '/users/profile' ,params: { :id => user.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:profile)
    end
  end

  # user profile edit
  describe "/users/editProfile" do
    scenario "user editProfile" do
      user = User.last
      get '/users/editProfile' ,params: { :id => user.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:editProfile)
    end
  end

  # user password edit page
  describe "/users/editPassword" do
    scenario "user editPassword" do
      user = User.last
      get '/users/editPassword' ,params: { :id => user.id }
      expect(response.status).to eq(200)
      expect(response).to render_template(:editPassword)
    end
  end

  # user profile update
  describe "/users/editProfile" do
    scenario "update user profile with valid params" do
      last_user_id = User.last.id
      update_user_params[:id] = last_user_id
      patch "/users/editProfile/", params: { user: update_user_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      expect(updated_user.name).to eq("Everlynn")
    end

    scenario "update user profile with invalid params" do
      last_user_id = User.last.id
      invalid_user_params[:id] = last_user_id
      patch "/users/editProfile/", params: { user_contract_update: invalid_user_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      expect(updated_user.name).not_to eq("Everlynn")
      expect(assigns(:form).errors[:name][0]).to eq "can't be blank"
      expect(response).to render_template(:editProfile)
    end
  end

  # user password update
  describe "/users/editPassword" do
    scenario "update password with valid params" do
      last_user_id = User.last.id
      last_updated_at = User.last.updated_at
      update_user_params[:id] = last_user_id
      patch "/users/editPassword/", params: { user: valid_password_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      new_updated_at = updated_user.updated_at
      expect(last_updated_at).not_to eq(new_updated_at)
    end

    scenario "update password with invalid params" do
      last_user_id = User.last.id
      last_updated_at = User.last.updated_at
      invalid_password_params[:id] = last_user_id
      patch "/users/editPassword/", params: { user_contract_update: invalid_password_params , id: last_user_id}
      updated_user = User.find_by(id: last_user_id)
      new_updated_at = updated_user.updated_at
      expect(last_updated_at).to eq(new_updated_at)
      expect(assigns(:form).errors[:password][0]).to eq "can't be blank"
      expect(response).to render_template(:editPassword)
    end
  end

end
