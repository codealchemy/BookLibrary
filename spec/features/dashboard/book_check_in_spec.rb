require 'rails_helper'

RSpec.feature 'Book checkout', type: :feature do
  let(:admin) { create(:admin) }
  let(:checked_out_book) { create(:book) }

  before do
    checked_out_book.loans.create(user: admin, due_date: Loan::DEFAULT_CHECKOUT_PERIOD.from_now)
  end

  context 'checked out by the current user' do
    before { sign_in(admin) }

    scenario 'returning a book' do
      visit rails_admin.check_in_path(model_name: "Book", id: checked_out_book.id)

      expect do
        click_on I18n.t("admin.actions.check_in.submit_button", title: checked_out_book.title)
      end.to change { checked_out_book.loans.active.count }.by(-1)

      within(".alert") do
        expect(page).to have_content(
          I18n.t("admin.actions.check_in.success", title: checked_out_book.title)
        )
      end
    end
  end

  context 'checked out by another user' do
    before { sign_in(create(:user)) }

    scenario 'option to check in should not be visible on show page' do
      visit rails_admin.show_path(model_name: "Book", id: checked_out_book.id)

      expect(page).to_not have_content(I18n.t("admin.actions.check_in.menu"))
    end

    scenario 'button for check in should be disabled on check in page' do
      visit rails_admin.check_in_path(model_name: "Book", id: checked_out_book.id)

      expect(page.find_button(
        I18n.t("admin.actions.check_in.submit_button", title: checked_out_book.title),
        disabled: true)
      ).to be_present
    end
  end
end
