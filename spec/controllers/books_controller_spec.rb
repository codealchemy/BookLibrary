require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:test_book) { create(:book, title: 'Find me') }
  before { allow_any_instance_of(NationBuilder::Client).to receive(:call) }

  describe 'GET #index' do
    context 'logged-in user' do
      before { sign_in(user) }

      it 'renders the :index template for users' do
        get :index

        expect(response).to render_template(:index)
      end

      it 'defaults to showing all books' do
        get :index

        expect(assigns[:books]).to match_array([test_book])
      end

      it 'includes book matched by the search when provided' do
        get :index, title_search: 'me'

        expect(assigns[:books]).to match_array([test_book])
      end
    end

    context 'user not logged in' do
      it 'redirects to login' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end
  end

  describe 'GET #show/:id' do
    before do
      sign_in(user)
    end

    it 'renders the :show template' do
      allow(AmazonBook).to receive(:search_by_isbn)

      get :show, id: test_book.id

      expect(response).to render_template(:show)
    end

    it 'raises record not found error with invalid record' do
      expect {
        get :show, id: 'not_existing_book'
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #check_out' do
    before do
      sign_in(user)
      allow(Nb::Contacts).to receive(:type_id).and_return(1)
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
      allow(Nb::Contacts).to receive(:type_id).and_return(1)
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
end
