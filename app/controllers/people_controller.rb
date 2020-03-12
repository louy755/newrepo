class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def more
    @people = Person.all
    @goods = Good.all
    @pays = Pay.all
    @delivers = Deliver.all
  end
  def index
    @people = Person.all.order("created_at DESC")
  end
  def show
    respond_to do |format|
    format.html
      format.pdf do
        pdf = InvoicePdf.new(@person, view_context)
        send_data pdf.render, filename: "invoice_#{@person.phone}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
  def new
    @person = current_user.people.build
  end
  def edit
  end
  def create
    @person = current_user.people.build(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, success: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, info: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, warning: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_person
    @person = Person.find(params[:id])
  end
  def person_params
    params.require(:person).permit(:name, :phone, :email, :address, :address2, :city,
      :state, :zip, :sub_total, :tax, :total, :slae_rep, :profit, :margin, :cost, :delivery,
      :fee, :discount, :finance, :tax_inc, :user_id, :financ_com)
  end
end
