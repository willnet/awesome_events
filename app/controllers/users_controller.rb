# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :authenticate

  def retire
  end

  def destroy
    if current_user.destroy
      reset_session
      redirect_to root_path, notice: '退会完了しました'
    else
      render :retire
    end
  end
end
