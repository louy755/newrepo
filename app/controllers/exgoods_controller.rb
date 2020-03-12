class ExgoodsController < ApplicationController
  def index
    @exgoods = Exgood.all.order("created_at DESC")
  end

  def show
    @exgood = Exgood.find(params[:id])
  end

  def create
    @exrec = Exrec.find(params[:exrec_id])
    @exgood = @exrec.exgoods.build(exgood_params)
    @exgood.save
    respond_to do |format|
      format.html { redirect_to @exrec, success: 'Item was Added to your Recipt successfuly!.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @exgood = Exgood.find(params[:id])
    @exgood.destroy
    respond_to do |format|
      format.html { redirect_to @exgood.exrec, warning: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def exgood_params
    params.require(:exgood).permit(:qny, :price, :subtotal, :item, :description)
  end
end
