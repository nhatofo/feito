class OrdersController < ApplicationController
    before_action :authenticate_user!
    
    def create
        gig = Gig.find(params[:gig_id])
        pricing = gig.pricings.find_by(pricing_type: params[:pricing_type])

        if (pricing && !gig.has_single_pricing) || (pricing && pricing.basic? && gig.has_single_pricing)
            charge(gig, pricing)
        else
            flash[:alert] = "Valor incorrecto"
        end

        redirect_to request.referrer
    end

    def selling_orders
        @orders = current_user.selling_orders
    end

    def buying_orders
        @orders = current_user.buying_orders
    end

    def completo
        @order = Order.find(params[:id])

        if !@order.completo?
            if @order.completo!
                flash[:notice] = "Guardado...."
            else
                flash[:alert] = "Algo de errado ocorreu"
            end
            
            redirect_to request.referrer
        end
    end

    private

    def charge(gig, pricing)
        order = gig.orders.new
        order.due_date = Date.today() + pricing.delivery_time.days
        order.title = gig.title
        order.seller_name = gig.user.full_name
        order.seller_id = gig.user.id
        order.buyer_name = current_user.full_name
        order.buyer_id = current_user.id
        order.amount = pricing.price

        if order.save
            flash[:notice] = "Compra criada com sucesso"
        else
            flash[:alert] = order.errors.full_messages.join(', ')
        end
    end
end