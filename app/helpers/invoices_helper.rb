module InvoicesHelper
  def invoice_status_link(invoice, total_amount)
    controls = ""

    controls = controls + content_tag(:td) do
      link_to("[#{t("invoice.view")}]", invoice_path(invoice))
    end

    if invoice.status == "draft"
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.issue")}]", issue_invoice_path(invoice))
      end
    end

    if invoice.status == "issued"
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.send")}]", send_state_invoice_path(invoice))
      end
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.archive")}]", archive_invoice_path(invoice))
      end
    end

    if invoice.status == "sent"
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.archive")}]", archive_invoice_path(invoice))
      end

      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.record_payment")}]", '#', data: {toggle: "modal", target: "#paymentdlg"}, :onclick => "onpayment(#{invoice.id}, '#{invoice.clinical_trial.study_title}', #{total_amount});")
      end
    end

    if invoice.status == "archived"
    end

    if invoice.status == "paid"
    end

    if invoice.status == "partially_paid"
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.record_payment")}]", '#', data: {toggle: "modal", target: "#paymentdlg"}, :onclick => "onpayment(#{invoice.id}, #{invoice.clinical_trial.study_title}, #{total_amount});")
      end
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.cancel")}]", cancel_invoice_path(invoice))
      end
    end

    if invoice.status == "cancelled"
    end

    unless invoice.status == "archived"
      controls = controls + content_tag(:td) do
        link_to("[#{t("invoice.edit")}]", edit_invoice_path(invoice))
      end
    end

    controls = controls + content_tag(:td) do
      link_to("[#{t("invoice.delete")}]", invoice_path(invoice), :method => :delete, :data => { :confirm => "#{t("invoice.confirm_message")}" })
    end

    controls.html_safe
  end

  def invoice_status_button(invoice)
    controls = ""

    if invoice.status == "draft"
      controls = controls + content_tag(:td) do
        link_to(t("invoice.issue"), issue_invoice_path(invoice), class: "btn btn-success")
      end
    end

    if invoice.status == "issued"
      controls = controls + content_tag(:td) do
        link_to(t("invoice.send"), send_state_invoice_path(invoice), class: "btn btn-success")
      end
      controls = controls + content_tag(:td) do
        link_to(t("invoice.archive"), archive_invoice_path(invoice), class: "btn btn-success")
      end
    end

    if invoice.status == "sent"
      controls = controls + content_tag(:td) do
        link_to(t("invoice.archive"), archive_invoice_path(invoice), class: "btn btn-success")
      end

      controls = controls + content_tag(:td) do
        link_to(t("invoice.record_payment"), '#', data: {toggle: "modal", target: "#paymentdlg"}, :onclick => "onpayment();", class: "btn btn-success")
      end
    end

    if invoice.status == "archived"
    end

    if invoice.status == "paid"
    end

    if invoice.status == "partially_paid"
      controls = controls + content_tag(:td) do
        link_to(t("invoice.record_payment"), '#', data: {toggle: "modal", target: "#paymentdlg"}, :onclick => "onpayment();", class: "btn btn-success")
      end
      controls = controls + content_tag(:td) do
        link_to(t("invoice.cancel"), cancel_invoice_path(invoice), class: "btn btn-success")
      end
    end

    if invoice.status == "cancelled"
    end

    unless invoice.status == "archived"
      controls = controls + content_tag(:td) do
        link_to(t("invoice.edit"), edit_invoice_path(invoice), class: "btn btn-success")
      end
    end

    controls.html_safe
  end
end
