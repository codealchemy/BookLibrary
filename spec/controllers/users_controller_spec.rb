require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  context 'admin' do
    before(:each) do
      sign_in(admin)
    end

    describe 'GET #index' do
      it 'renders the :index view' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #show' do
      it 'renders the :show template' do
        user_test = create(:user, email: 'faveabe@example.com')
        get :show, id: user_test.id
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders the :new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new user' do
          expect {
            post :create, user: FactoryGirl.attributes_for(:user)
          }.to change { User.count }.by(1)
        end
        it 'redirects to users_path' do
          post :create, user: FactoryGirl.attributes_for(:user)
          expect(response).to redirect_to(users_admin_index_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the user in the database' do
          expect {
            post :create, user: FactoryGirl.attributes_for(:user, password: nil)
          }.not_to change { User.count }
        end
        it 're-renders the :new template' do
          post :create, user: FactoryGirl.attributes_for(:user, password: nil)
          expect(flash[:alert]).to eq('There\'s an error - please check the required fields')
          expect(response).to redirect_to(new_users_admin_path)
        end
      end
    end
  end

  context 'user' do
    before(:each) do
      sign_in(user)
    end

    describe 'GET #index' do
      it 'doesn\'t render the :index view' do
        get :index
        expect(flash[:alert]).to eq('That\'s off limits!')
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #show' do
      it 'renders the :show template' do
        user_test = create(:user, email: 'faveabe@example.com')
        get :show, id: user_test.id
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders the :new template' do
        get :new
        expect(flash[:alert]).to eq('That\'s off limits!')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
