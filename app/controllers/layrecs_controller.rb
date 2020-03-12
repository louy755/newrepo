class LayrecsController < ApplicationController
  before_action :set_layrec, only: [:show, :edit, :update, :destroy]
  def morelay
    @layrecs = Layrec.all
    @goodlays = Goodlay.all
    @paylays = Paylay.all
    @deliverlays = Deliverlay.all
  end
  def index
    @layrecs = Layrec.all.order("created_at DESC")
  end

  def new
    @layrec = current_user.layrecs.build
  end

  def show
    respond_to do |format|
    format.html
      format.pdf do
        pdf = InvoiceLayPdf.new(@layrec, view_context)
        send_data pdf.render, filename: "invoice_#{@layrec.phone}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def edit
  end

  def create
    @layrec = current_user.layrecs.build(layrec_params)

    respond_to do |format|
      if @layrec.save
        format.html { redirect_to @layrec, success: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @layrec.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @layrec.update(layrec_params)
        format.html { redirect_to @layrec, info: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @layrec }
      else
        format.html { render :edit }
        format.json { render json: @layrec.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @layrec.destroy
    respond_to do |format|
      format.html { redirect_to layrec_url, warning: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_layrec
    @layrec = Layrec.find(params[:id])
  end

  def layrec_params
    params.require(:layrec).permit(:name, :phone, :email, :address, :address2, :city,
      :state, :zip, :sub_total, :tax, :total, :sale_rep, :profit, :margin, :cost,
      :delivery, :fee, :discount, :tax_inc, :tot_pauments, :user_id)
  end
end
