require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
    let(:user_test) { create(:user, email: 'faveabe@example.com') }

    it 'renders the :show template' do
      get :show, id: user_test.id

      expect(response).to render_template(:show)
    end

    it 'assigns the user to an instance variable' do
      get :show, id: user_test.id

      expect(assigns[:user]).to eq(user_test)
    end
  end
end
