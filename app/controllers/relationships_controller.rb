class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:id])
  end

  def destroy
  end
end
