class DeliverlaysController < ApplicationController
  def index
    @deliverlays = Deliverlay.all.order("created_at DESC")
  end

  def show
    @deliverlay = Deliverlay.find(params[:id])
  end

  def create
    @layrec = Layrec.find(params[:layrec_id])
    @deliverlay = @layrec.deliverlays.build(deliverlay_params)
    @deliverlay.save
    respond_to do |format|
        format.html { redirect_to @layrec, success: 'Delivery Details was successfully Created.' }
        format.json { head :no_content }
    end
  end

  def destroy
    @deliverlay = Deliverlay.find(params[:id])
    @deliverlay.destroy
    respond_to do |format|
        format.html { redirect_to @deliverlay.layrec, warning: 'Delivery Details was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
  def deliverlay_params
    params.require(:deliverlay).permit(:delivery, :fee, :discount)
  end
end
