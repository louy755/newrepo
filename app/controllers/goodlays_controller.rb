class GoodlaysController < ApplicationController
  def index
    @goodlays = Goodlay.all.order("created_at DESC")
  end

  def show
    @goodlay = Goodlay.find(params[:id])
  end

  def create
    @layrec = Layrec.find(params[:layrec_id])
    @goodlay = @layrec.goodlays.build(goodlay_params)
    @goodlay.save
    respond_to do |format|
      format.html { redirect_to @layrec, success: 'Item was Added to your Recipt successfuly!.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @goodlay = Goodlay.find(params[:id])
    @goodlay.destroy
    respond_to do |format|
      format.html { redirect_to @goodlay.layrec, warning: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def goodlay_params
    params.require(:goodlay).permit(:qny, :price, :subtotal, :vendor, :item, :discription)
  end
end
