require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:test_book) { create(:book) }

  describe 'GET #index' do
    it 'renders the :index template for users' do
      sign_in(user)
      get :index
      expect(response).to render_template(:index)
    end
    it 'redirects to login if user not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  describe 'GET #show/:id' do
    before do
      sign_in(user)
    end

    it 'renders the :show template' do
      book = create(:book)
      get :show, id: book.id
      expect(response).to render_template(:show)
    end
    it 'raises record not found error with invalid record' do
      expect {
        get :show, id: 'not_existing_book'
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #new' do
    context 'as admin' do
      it 'renders the :new template' do
        sign_in(admin)
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'as user' do
      it 'redirects non-admins to book index' do
        sign_in(user)
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    before do
      sign_in(admin)
    end

    context 'with valid attributes' do
      it 'saves the book in the database' do
        expect {
          post :create, book: FactoryGirl.attributes_for(:book)
        }.to change { Book.count }.by(1)
      end
      it 'redirects user to book index' do
        post :create, book: FactoryGirl.attributes_for(:book)
        expect(flash[:notice]).to eq('Book saved')
        expect(response).to redirect_to(books_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the connection in the database' do
        expect {
          post :create, book: FactoryGirl.attributes_for(:book, isbn: nil)
        }.not_to change { Book.count }
      end
      it 're-renders the :new template' do
        post :create, book: FactoryGirl.attributes_for(:book, isbn: nil)
        expect(flash[:alert]).to eq('There\'s an error - please check the required fields')
        expect(response).to redirect_to(new_book_path)
      end
    end
  end

  describe 'POST #check_out' do
    before(:each) do
      sign_in(user)
    end

    it 'checks out a book for a user' do
      post :check_out, id: test_book.id
      expect(user.books_checked_out).to include(test_book)
    end
    it 'creates a new loan for the check-out' do
      expect {
        post :check_out, id: test_book.id
      }.to change { Loan.count }.by(1)
    end
    it 'redirects to books index after checkout' do
      post :check_out, id: test_book.id
      expect(response).to redirect_to(books_path)
    end
  end

  describe 'POST #check_in' do
    before do
      sign_in(user)
      user.check_out(test_book)
    end

    it 'checks in a book for the user' do
      post :check_in, id: test_book.id
      expect(user.books_checked_out).not_to include(test_book)
    end
    it 'redirects to books index after check-in' do
      post :check_in, id: test_book.id
      expect(response).to redirect_to(books_path)
    end
  end

  describe 'DELETE #destroy/:id' do
    before do
      sign_in(admin)
    end

    it 'deletes the requested book' do
      book = create(:book)
      expect {
        delete :destroy, id: book.id
      }.to change { Book.count }.by(-1)
    end

    it 'redirects to books list' do
      book = create(:book)
      delete :destroy, id: book.id
      expect(flash[:alert]).to eq('Book has been deleted')
      expect(response).to redirect_to(books_path)
    end
  end
end
