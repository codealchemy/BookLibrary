require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class CheckIn < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:object].try(:checked_out?) &&
            bindings[:object].loans.active.last.user == bindings[:controller].current_user
        end

        register_instance_option :link_icon do
          "icon-stop"
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
              loan = @object.loans.active.find_by(user: current_user)

              if loan.update_attributes(checked_in_at: Time.zone.now)
                flash[:success] = I18n.t("admin.actions.check_in.success", title: @object.title)
                redirect_to index_path(model_name: :book)
              else
                flash[:error] = I18n.t("admin.actions.checkin.error")
              end
            end
          end
        end
      end
    end
  end
end
