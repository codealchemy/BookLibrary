require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'admin' do
    describe 'GET #index' do
      it 'shows an list of users'
      it 'renders the :index view'
    end

    describe 'GET #show' do
      it 'shows the requested '
      it 'renders the :show template'
    end

    describe 'GET #new' do
      it 'creates new user'
      it 'renders the :new template'
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new user'
        it 'redirects to users_path'
      end

      context 'with invalid attributes' do
        it 'does not save the user in the database'
        it 're-renders the :new template'
      end
    end
  end

  context 'user' do
    describe 'GET #index' do
      it 'shows an list of users'
      it 'renders the :index view'
    end

    describe 'GET #show' do
      it 'shows the requested '
      it 'renders the :show template'
    end

    describe 'GET #new' do
      it 'creates new location'
      it 'renders the :new template'
    end
  end
end
