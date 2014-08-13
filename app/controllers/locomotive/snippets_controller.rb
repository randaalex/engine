module Locomotive
  class SnippetsController < BaseController

    localized

    before_filter :back_to_default_site_locale, only: %w(new create)

    respond_to    :json, only: [:show, :create, :update, :destroy]

    def new
      @snippet = current_site.snippets.new
      respond_with @snippet
    end

    def show
      @snippet = current_site.snippets.find(params[:id])
      respond_with @snippet
    end

    def create
      @snippet = current_site.snippets.create(params[:snippet])
      respond_with @snippet, location: edit_snippet_path(@snippet._id)
    end

    def edit
      @snippet = current_site.snippets.find(params[:id])
      respond_with @snippet
    end

    def update
      @snippet = current_site.snippets.find(params[:id])
      @snippet.update_attributes(params[:snippet])
      respond_with @snippet, location: edit_snippet_path(@snippet._id)
    end

    def destroy
      @snippet = current_site.snippets.find(params[:id])
      @snippet.destroy
      respond_with @snippet, location: theme_assets_path
    end

  end
end