module Api
	module V1
		class QuestionnaireFormFieldsController < ApplicationController
			before_action :set_donor_questionnaire_form

		  def index
		    render json: @donor_questionnaire_form.questionnaire_form_fields
		  end

		  def show
		    render json: @donor_questionnaire_form.questionnaire_form_fields.find(params[:id])
		  end

		  def create
		    field = @donor_questionnaire_form.questionnaire_form_fields.new(questionnaire_form_field_params)
		    if field.save
		      render json: field, status: :created
		    else
		      render json: field.errors, status: :unprocessable_entity
		    end
		  end

		  def update
		    field = @donor_questionnaire_form.questionnaire_form_fields.find(params[:id])
		    if field.update(questionnaire_form_field_params)
		      render json: field
		    else
		      render json: field.errors, status: :unprocessable_entity
		    end
		  end

		  def destroy
		    field = @donor_questionnaire_form.questionnaire_form_fields.find(params[:id])
		    field.destroy
		    head :no_content
		  end

		  private

		  def set_donor_questionnaire_form
		    @donor_questionnaire_form = DonorQuestionnaireForm.find(params[:donor_questionnaire_form_id])
		  end

		  def questionnaire_form_field_params
		    params.require(:questionnaire_form_field).permit(:field_type, :label, :options, :required)
		  end
		end
	end
end
