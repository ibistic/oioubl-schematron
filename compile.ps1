Param(
    [string]$xsltcPath = "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\xsltc.exe"
)

$version = Get-Content .\version.json -Raw | ConvertFrom-Json | Select-Object -ExpandProperty AssemblyVersion
Write-Host ("Assembly version: $version")


New-Item -ItemType Directory -Force -Path .\full\lib\net40
New-Item -ItemType Directory -Force -Path .\simpleinvoice\lib\net40

Invoke-Expression '& "$xsltcPath" /out:full\lib\net40\OioUbl.Schematron.dll /version:"$version" /class:OioUbl.ApplicationResponseSchematron Stylesheets\OIOUBL_ApplicationResponse_Schematron.xsl /class:OioUbl.CatalogueSchematron Stylesheets\OIOUBL_Catalogue_Schematron.xsl /class:OioUbl.CatalogueDeletionSchematron Stylesheets\OIOUBL_CatalogueDeletion_Schematron.xsl /class:OioUbl.CatalogueItemSpecificationUpdateSchematron Stylesheets\OIOUBL_CatalogueItemSpecificationUpdate_Schematron.xsl /class:OioUbl.CataloguePricingUpdateSchematron Stylesheets\OIOUBL_CataloguePricingUpdate_Schematron.xsl /class:OioUbl.CatalogueRequestSchematron Stylesheets\OIOUBL_CatalogueRequest_Schematron.xsl /class:OioUbl.CreditNoteSchematron Stylesheets\OIOUBL_CreditNote_Schematron.xsl /class:OioUbl.InvoiceSchematron Stylesheets\OIOUBL_Invoice_Schematron.xsl /class:OioUbl.OrderSchematron Stylesheets\OIOUBL_Order_Schematron.xsl /class:OioUbl.OrderCancellationSchematron Stylesheets\OIOUBL_OrderCancellation_Schematron.xsl /class:OioUbl.OrderChangeSchematron Stylesheets\OIOUBL_OrderChange_Schematron.xsl /class:OioUbl.OrderResponseSchematron Stylesheets\OIOUBL_OrderResponse_Schematron.xsl /class:OioUbl.OrderResponseSimpleSchematron Stylesheets\OIOUBL_OrderResponseSimple_Schematron.xsl /class:OioUbl.ReminderSchematron Stylesheets\OIOUBL_Reminder_Schematron.xsl /class:OioUbl.StatementSchematron Stylesheets\OIOUBL_Statement_Schematron.xsl /class:OioUbl.UtilityStatementSchematron Stylesheets\OIOUBL_UtilityStatement_Schematron.xsl'

Invoke-Expression '& "$xsltcPath" /out:simpleinvoice\lib\net40\OioUbl.Schematron.SimpleInvoice.dll /version:"$version" /class:OioUbl.ApplicationResponseSchematron Stylesheets\OIOUBL_ApplicationResponse_Schematron.xsl /class:OioUbl.CreditNoteSchematron Stylesheets\OIOUBL_CreditNote_Schematron.xsl /class:OioUbl.InvoiceSchematron Stylesheets\OIOUBL_Invoice_Schematron.xsl  /class:OioUbl.ReminderSchematron Stylesheets\OIOUBL_Reminder_Schematron.xsl /class:OioUbl.StatementSchematron Stylesheets\OIOUBL_Statement_Schematron.xsl'