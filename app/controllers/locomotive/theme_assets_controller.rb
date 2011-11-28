module Locomotive
  class ThemeAssetsController < BaseController

    sections 'settings', 'theme_assets'

    respond_to :json, :only => [:index, :create, :update]

    def index
      respond_to do |format|
        format.html {
          @assets             = ThemeAsset.all_grouped_by_folder(current_site)
          @js_and_css_assets  = (@assets[:javascripts] || []) + (@assets[:stylesheets] || [])
          @snippets           = current_site.snippets.order_by([[:name, :asc]]).all.to_a
          render
        }
        format.json {
          render :json => current_site.theme_assets.by_content_type(params[:content_type])
        }
      end
    end

    def new
      @asset = current_site.theme_assets.build(params[:id])
      respond_with @asset
    end

    def create
      @asset = current_site.theme_assets.create(params[:theme_asset])
      respond_with @asset, :location => edit_theme_asset_url(@asset._id)
    end

    def edit
      @asset = current_site.theme_assets.find(params[:id])
      resource.performing_plain_text = true if resource.stylesheet_or_javascript?
      respond_with @asset
    end

    def update
      @asset = current_site.theme_assets.find(params[:id])
      @asset.update_attributes(params[:theme_asset])
      respond_with @asset, :location => edit_theme_asset_url(@asset._id)
    end

    def destroy
      @asset = current_site.theme_assets.find(params[:id])
      @asset.destroy
      respond_with @asset
    end

  end

end