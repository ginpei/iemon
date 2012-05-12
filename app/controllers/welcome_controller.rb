class WelcomeController < ApplicationController
  def index
    @theme = Theme.active.first
    render 'themes/show'
  end
end
