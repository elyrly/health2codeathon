Rails.application.routes.draw do
  devise_for :users
  root to: 'med#index'

  get '/patient_list' => 'med#patient_list'
  get '/patient_lists' => 'med#patient_lists'
  get 'session/new' => 'medicalsession#new_session'
  get 'session/1/medicine/1/education'=>  'medicine#drug_education'
  get 'session/1/survey/1'=>  'survey#patient_survey'


    get '/better_doctor' => 'med#better_doctor'
end
