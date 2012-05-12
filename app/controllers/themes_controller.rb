class ThemesController < ApplicationController
  # GET /themes
  # GET /themes.json
  def index
   # @themes = Theme.order("target_date DESC").all
    @themes = Theme.where('target_date IS NOT NULL').where('target_date <= ?', Date.today).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
    @theme = Theme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @theme }
    end
  end

  # GET /themes/new
  # GET /themes/new.json
  def new
    only_administer
    @theme = Theme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @theme }
    end
  end

  # GET /themes/1/edit
  def edit
    only_administer
    @theme = Theme.find(params[:id])
  end

  # POST /themes
  # POST /themes.json
  def create
    only_administer
    @theme = Theme.new(params[:theme])

    respond_to do |format|
      if @theme.save
        format.html { redirect_to themes_path, notice: 'Theme was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /themes/1
  # PUT /themes/1.json
  def update
    only_administer
    @theme = Theme.find(params[:id])

    respond_to do |format|
      if @theme.update_attributes(params[:theme])
        format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    only_administer

    @theme = Theme.find(params[:id])
    @theme.destroy

    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  # GET /themes/edit_active
  def edit_active
    only_administer

    @active = Theme.active.first
    @themes = Theme.order("target_date DESC").all
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # POST /themes/activate
  def activate
    only_administer

    if params[:active] != 'true'
      respond_to do |format|
        d = params['date']
        date = Date.new(d["year"].to_i, d["month"].to_i, d["day"].to_i)
        begin
          Theme.activate(date)
          format.html { redirect_to :edit_active_themes, notice: 'Theme was successfully actavatied.' }
        rescue => e
          format.html { redirect_to :edit_active_themes, warning: 'failed to update' }
        end
      end
    else
      Theme.deactivate
      respond_to do |format|
        format.html { redirect_to :edit_active_themes, notice: 'Theme was successfully deactivate.' }
      end
    end
  end
end
