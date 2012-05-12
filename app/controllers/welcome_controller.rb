class WelcomeController < ApplicationController
  def index
    @theme = Theme.today
    render 'themes/show'
  end
end
