class PaylaysController < ApplicationController
  def index
    @paylays = Paylay.all
  end

  def show
    @paylay = Paylay.find(params[:id])
  end

  def create
    @layrec = Layrec.find(params[:layrec_id])
    @paylay = @layrec.paylays.build(paylay_params)
    @paylay.save
    respond_to do |format|
      format.html { redirect_to @layrec, success: 'Amount was successfully Created.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @paylay = Paylay.find(params[:id])
    @paylay.destroy
    respond_to do |format|
      format.html { redirect_to @paylay.layrec, warning: 'Amount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def paylay_params
    params.require(:paylay).permit(:method, :amount, :sale_rep)
  end
end
