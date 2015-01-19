require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe 'GET #index' do
    it 'shows an list of locations for the user'
    it 'renders the :index view'
  end

  describe 'GET #show' do
    it 'shows the requested location to the user'
    it 'renders the :show template'
  end

  describe 'GET #new' do
    it 'creates new location'
    it 'renders the :new template'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new location'
      it 'redirects to locations_path'
    end

    context 'with invalid attributes' do
      it 'does not save the location in the database'
      it 're-renders the :new template'
    end
  end
end
