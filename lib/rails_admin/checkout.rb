require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Checkout < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:object].try(:available?)
        end

        register_instance_option :link_icon do
          "icon-download"
        end

        register_instance_option :member? do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          proc do
            if request.post?
              loan = @object.loans.new(user: current_user,
                                       checked_out_at: Time.zone.now,
                                       due_date: Loan::DEFAULT_CHECKOUT_PERIOD.from_now)
              if loan.save
                flash[:success] = I18n.t("admin.actions.checkout.success",
                                         title: @object.title,
                                         due_date: loan.due_date.to_formatted_s(:long_ordinal))
                redirect_to index_path(model_name: :book)
              else
                flash[:error] = loan.errors.full_messages.join(', ')
              end
            end
          end
        end
      end
    end
  end
end
