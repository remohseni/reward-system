class WelcomeController < ActionController::Base
  append_view_path "#{Rails.root}/app/views"
  def index
    render 'welcome/index'
  end
end
