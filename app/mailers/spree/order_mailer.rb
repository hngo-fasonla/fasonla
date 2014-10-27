require 'socket'

module Spree
  class OrderMailer < BaseMailer
    def confirm_email(order, resend = false)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = "Your order number is [ #{@order.number} ]."
      
      @order.line_items.each do |item|
        attachments.inline[item.variant.images.first.attachment.url(:mini, false)] = File.read( "#{Rails.root.to_s + '/public' }" + item.variant.images.first.attachment.url(:mini, false) )
      end
      #attachments.inline['ror_mug.jpeg'] = File.read( "#{Rails.root.to_s + '/public/spree/products/27/small/ror_mug.jpeg'}" )
      mail(to: @order.email, from: from_address, subject: subject)
    end

    def cancel_email(order, resend = false)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.current.name} #{Spree.t('order_mailer.cancel_email.subject')} ##{@order.number}"
      mail(to: @order.email, from: from_address, subject: subject)
    end
  end
end
