class ExdlvsController < ApplicationController
  def index
    @exdlvs = Exdlv.all.order("created_at DESC")
  end

  def show
    @exdlv = Exdlv.find(params[:id])
  end

  def create
    @exrec = Exrec.find(params[:exrec_id])
    @exdlv = @exrec.exdlvs.build(exdlv_params)
    @exdlv.save
    respond_to do |format|
        format.html { redirect_to @exrec, success: 'Delivery Details was successfully Created.' }
        format.json { head :no_content }
    end
  end

  def destroy
    @exdlv = Exdlv.find(params[:id])
    @exdlv.destroy
    respond_to do |format|
        format.html { redirect_to @exdlv.exrec, warning: 'Delivery Details was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
  def exdlv_params
    params.require(:exdlv).permit(:delivery, :fee, :discount)
  end
end
