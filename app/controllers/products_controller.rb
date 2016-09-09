class ProductsController < RankingController

  def index
    @products = Product.all.limit(20)
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%")
  end


end
