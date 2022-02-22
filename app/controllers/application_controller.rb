# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandling
  include Authentication
  require 'zip'
end
