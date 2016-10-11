<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pay.aspx.cs" Inherits="Khadmatcom.OnlinePayment.Pay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script>
    var wpwlOptions = {
        locale: "<%= HyperPayClient.MerchantConfiguration.Config.Locale %>"
    }
</script>
</head>
<body>
    <script src="https://test.oppwa.com/v1/paymentWidgets.js?checkoutId=<%= Request.QueryString["cid"] %>"></script>
    <form action="<%= HyperPayClient.MerchantConfiguration.Config.ReturnUrl %>" class="paymentWidgets">VISA MASTER AMEX</form>
</body>
</html>
