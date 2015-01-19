require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { build(:book) }

  describe 'GET #index' do
    it 'shows an list of books'
    it 'renders the :index view for users' do
    end

    it 'redirects to login if user not logged in'
  end

  describe 'GET #show' do
    it 'shows the requested book to the user'
    it 'renders the :show template'
  end

  describe 'GET #new' do
    context 'as admin' do
      it 'creates new book'
      it 'renders the :new template'
    end

    context 'as user' do
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do

    end

    context 'with invalid attributes' do
      it 'does not save the connection in the database'
      it 're-renders the :new template'
    end
  end

  describe 'POST #check_out' do
  end

  describe 'POST #check_in' do
  end
end
