require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let!(:location) { create(:location) }
  let!(:user) { create(:user, location: location) }
  let!(:book) { create(:book, location: location) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index

      expect(response).to render_template(:index)
    end

    it 'assigns the locations instance variable' do
      get :index

      expect(assigns[:locations]).to match_array([location])
    end
  end

  describe 'GET #show' do
    it 'renders the :show template' do
      get :show, id: location.id

      expect(response).to render_template(:show)
    end

    it 'assigns associated instance variables' do
      get :show, id: location.id

      expect(assigns[:location]).to eq(location)
      expect(assigns[:users]).to match_array([user])
      expect(assigns[:books]).to match_array([book])
    end
  end
end
