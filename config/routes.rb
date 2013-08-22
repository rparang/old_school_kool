OldSchoolCool::Application.routes.draw do
  scope "api" do
    resources :images
  end

  root :to => "main#index"

end
