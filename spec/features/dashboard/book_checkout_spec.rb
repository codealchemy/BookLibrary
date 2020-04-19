require 'rails_helper'

RSpec.feature 'Book checkout', type: :feature do
  let(:admin) { create(:admin) }
  let(:available_book) { create(:book) }
  let(:checked_out_book) { create(:book) }

  before do
    sign_in(admin)
    checked_out_book.loans.create(user: admin, due_date: Loan::DEFAULT_CHECKOUT_PERIOD.from_now)
  end

  context 'available' do
    scenario 'checking out a book' do
      visit rails_admin.checkout_path(model_name: "Book", id: available_book.id)

      expect(page).to have_content(available_book.description)

      expect do
        click_on I18n.t("admin.actions.checkout.submit_button", title: available_book.title)
      end.to change { available_book.loans.count }.by(1)

      within(".alert") do
        expect(page).to have_content(
          I18n.t("admin.actions.checkout.success",
                 title: available_book.title,
                 due_date: available_book.loans.last.due_date.to_formatted_s(:long_ordinal))
        )
      end
    end
  end

  context 'not available' do
    scenario 'option to checkout should not be visible on show page' do
      visit rails_admin.show_path(model_name: "Book", id: checked_out_book.id)

      expect(page).to_not have_content(I18n.t("admin.actions.checkout.menu"))
    end

    scenario 'button for checkout should be disabled on checkout page' do
      visit rails_admin.checkout_path(model_name: "Book", id: checked_out_book.id)

      expect(page.find_button(
        I18n.t("admin.actions.checkout.submit_button", title: checked_out_book.title),
        disabled: true)
      ).to be_present
    end
  end
end
