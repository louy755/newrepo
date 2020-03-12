class ExrecsController < ApplicationController
  before_action :set_exrec, only: [:show, :edit, :update, :destroy]

  def index
    @exrecs = Exrec.all.order("created_at DESC")
  end

  def show
    respond_to do |format|
    format.html
      format.pdf do
        pdf = SamplePdf.new(@exrec, view_context)
        send_data pdf.render, filename: "invoice_#{@exrec.phone}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def new
    @exrec = current_user.exrecs.build
  end

  def edit
  end

  def create
    @exrec = current_user.exrecs.build(exrec_params)

    respond_to do |format|
      if @exrec.save
        format.html { redirect_to @exrec, notice: 'Sample Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @exrec }
      else
        format.html { render :new }
        format.json { render json: @exrec.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exrec.update(exrec_params)
        format.html { redirect_to @exrec, notice: 'Sample Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @exrec }
      else
        format.html { render :edit }
        format.json { render json: @exrec.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exrec.destroy
    respond_to do |format|
      format.html { redirect_to exrecs_url, notice: 'Sample Invoice  was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_exrec
    @exrec = Exrec.find(params[:id])
  end

  def exrec_params
    params.require(:exrec).permit(:name, :phone, :email, :tax_inc, :user_id)
  end
end
