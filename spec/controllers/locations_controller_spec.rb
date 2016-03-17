require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'GET #index' do
    before do
      sign_in(user)
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:location) { create(:location) }

    it 'renders the :show template' do
      get :show, id: location.id
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template to admin' do
      sign_in(admin)
      get :new
      expect(response).to render_template(:new)
    end

    it 'redirects user to root path' do
      sign_in(user)
      get :new
      expect(flash[:alert]).to eq("That's off limits!")
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST #create' do
    before do
      sign_in(admin)
    end

    context 'with valid attributes' do
      it 'creates a new location' do
        expect {
          post :create, location: FactoryGirl.attributes_for(:location)
        }.to change { Location.count }.by(1)
      end
      it 'redirects to locations_path' do
        post :create, location: FactoryGirl.attributes_for(:location)
        expect(flash[:notice]).to eq('Location saved')
        expect(response).to redirect_to(locations_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the location in the database' do
        expect {
          post :create, location: FactoryGirl.attributes_for(:location, name: nil)
        }.not_to change { Location.count }
      end
      it 're-renders the :new template' do
        post :create, location: FactoryGirl.attributes_for(:location, name: nil)
        expect(flash[:alert]).to eq("There's an error - please check the required fields")
        expect(response).to redirect_to(new_location_path)
      end
    end
  end
end
