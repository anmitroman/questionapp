# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :require_authentication

    def index
      respond_to do |format|
        format.html do
          @users = User.order(created_at: :desc).page(params[:page])
        end

        format.zip { respond_with_zipped_file }
      end
    end

    private

    def respond_with_zipped_file
      compressed_filestream = Zip::OutputStream.write_buffer do |os|
        User.order(created_at: :desc).each do |user|
          os.put_next_entry "user_#{user.id}.xlsx"
          os.print render_to_string(
            layout: false, handlers: [:axlsx], formats: [:xlsx],
            template: 'admin/users/user',
            locals: { user: user }
          )
        end
      end

      compressed_filestream.rewind
      send_data compressed_filestream.read, filename: 'users.zip'
    end
  end
end
