Rails.application.routes.draw do
  post 'kramdown/preview' => 'kramdown#preview'
end
