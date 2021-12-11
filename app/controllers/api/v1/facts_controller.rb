# class Api::V1::FactsController < ApplicationController
# end

class Api::V1::FactsController < ApplicationController
  include AuthenticationCheck

  before_action :is_user_logged_in
  before_action :set_fact, only: [:show, :update, :destroy]

  # GET /members/:member_id/facts
  def index
    @member = Member.find(params[:member_id])
    render json: @member.facts # note that because the facts route is nested inside members
                             # we return only the facts belonging to that member
  end

  # GET /members/:member_id/facts/:id
  def show
    # your code goes here
    @fact = Fact.find(params[:id])
    render json: @fact, status: 201
  end

  # POST /members/:member_id/facts
  def create
    @member = Member.find(params[:member_id])
    @fact = @member.facts.new(fact_params)
    if @fact.save
      render json: @fact, status: 201
    else
      render json: { error: 
"The fact entry could not be created. #{@fact.errors.full_messages.to_sentence}"},
      status: 400
    end
  end

  # PUT /members/:member_id/facts/:id
  def update
    # your code goes here
    @fact = Fact.find(params[:id])
	
    if @fact.update_attributes(fact_param)
       redirect_to :action => 'show', :id => @fact
    else
       @members = Member.all
       render :action => 'edit'
    end 
  end

  # DELETE /members/:member_id/facts/:id
  def destroy
    # your code goes here
    @fact = Fact.find(params[:id])
    @fact.destroy
  end

  private

  def fact_params
    params.require(:fact).permit(:fact_text, :likes)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end

end