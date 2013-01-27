class FooController < ApplicationController
  respond_to :html, :json

  def show
    respond_with(Foo.find(params[:id]))
  end

  def best
    respond_with(Foo.best_list)
  end
end
