if Rails.env.staging? || Rails.env.production?
  WickedPdf.config = {
      :wkhtmltopdf => 'bin/wkhtmltopdf-linux-amd64'
      #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
      #exe_path: '/usr/local/bin/wkhtmltopdf'
      #:layout => "pdf.html",
  }
else
  WickedPdf.config = {
      #:wkhtmltopdf => 'bin/wkhtmltopdf',
      :wkhtmltopdf => '/usr/local/bin/wkhtmltopdf'
      #:layout => "pdf.html",
  }
end

