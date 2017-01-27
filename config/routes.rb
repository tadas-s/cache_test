# frozen_string_literal: true
Rails.application.routes.draw do
  get 'api/foo/:seed', controller: :api, action: :foo
end
