<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bank-data.aspx.cs" Inherits="Khadmatcom.admin_area.bank_data" %>

<%@ Import Namespace="Khadmatcom" %>
<%@ Import Namespace="Khadmatcom.Data.Model" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">التحويلات البنكية</a></li>
    </ul>
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
        <asp:ListView runat="server" ID="lvServiceRequest" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="3" ItemType="Khadmatcom.Data.Model.ServiceRequest" OnItemCommand="lvServiceRequest_OnItemCommand">
            <GroupTemplate>
                <div class="item">
                    <div class="accordion clearfix" id="accordion01">
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                    </div>
                </div>
            </GroupTemplate>
            <ItemTemplate>
                <div class="panel">
                    <div class="accordion-heading">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion4" href='#right<%# Item.Id %>' aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">رقم الطلب: <span class="red"><%# Item.Id %></span> </span>
                                    <span>الخدمة المطلوبة: <span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"title") %></span> </span>
                                    <span>نوعها:<span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"subcategory") %></span> </span>
                                 <span>العدد:<span class="blue"><%#Item.Count %></span> </span>
                                </div>
                                <div class="L1">
                                    <span class="ni">اسم شريك الخدمة: <span class="red"><%# Item.Provider.FullName %></span> </span>
                                    <span>رقم الجوال: <span class="blue"><%# Item.Provider.MobielNumber %></span> </span>
                                    <span>رقم الحساب: <span class="blue"><%# Item.Provider.BankAccountNumber %></span> </span>
                                </div>
                                <div class="clearfix"></div>
                                <div class="row L2">
                                    <div class="col-md-12 col-sm-12 col-xs-12 pull-right;">
                                        :تفاصيل الخدمة
                                    </div>
                                </div>
                                <div class="L3">
                                    <p>
                                        <%# Item.Details %>
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right<%# Item.Id %>" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix" dir="rtl" style="direction: rtl;">
                            <div class="list-group L-container">
                              <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>طريقة الدفع</label>
                                        :
                                                       &nbsp; <span class=""><%# GetPaymentMethod(Item.PaymentMethod) %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>اسم العميل </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.Client.FullName %></span>
                                    </div>
                                </div>
                                 <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>رقم الجوال </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.Client.MobielNumber %></span>
                                    </div>
                                </div>
                                
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>اسم البنك </label>
                                        :
                                                       &nbsp; <span class=""><%# ((Banks) int.Parse(Item.PaymentProviderName)).ToString().Replace("_"," ") %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>تاريخ التحويل </label>
                                        :
                                                       &nbsp; <span class=""><%# string.Format("{0}/{1}/{2}",Item.PaymentDate.Value.Year,Item.PaymentDate.Value.Month.ToString("00"),Item.PaymentDate.Value.Day.ToString("00")) %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>رقم الحساب المحول منه</label>
                                        :
                                                       &nbsp; <span class=""><%# Item.PaymentAccountNumber %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>رقم الحوالة(العملية) </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.PaymentReferanceCode %></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6 col-sm-12 col-xs-12 pull-right">
                                <%--<asp:Button Text="تم التاكيد" OnClientClick="return confirmRequest(<%# Item.Id %>)" CssClass="btn btn-success" runat="server" CommandName="Confirm" CommandArgument="<%# Item.Id %>" />--%>
                                <input type="button" class="btn btn-danger  btn-sm" value="تم التاكيد" onclick="return confirmRequest(<%# Item.Id %>);" />
                            </div>
                            <div class="L-button" id="">
                                <button type="button" style="padding: 3px; opacity: 1; color: green;" class="btn btn-default disabled text-success ">سعر الخدمة:<%# Item.CurrentPrice %>&nbsp;<span style="display: inline-block; float: left">ريال</span>&nbsp;  </button>
                            </div>

                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:ListView>



    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/carousel-js/owl.carousel.js"></script>
    <script src="/Scripts/carousel-js/owl.carousel.min.js"></script>
    <script type="text/javascript">

        function confirmRequest(id) {
           var a = confirm("هل انت متاكد؟");
            if (a == true) {
           
                var userData = {
                    id: id,dummy:false,x:0

                };

                $.getJSON("/api/Khadmatcom/ConfirmRequest", userData, function (res) {
                    showLoading();
                    if (res) {
                        setTimeout(function () {
                            //do what you need here
                            hideLoading();
                            toastr.success("تم تأكيد الطلب", "شكرا لك", { timeOut: 60000, rtl: true, closeButton: true, positionClass: 'toast-top-center' });

                        }, 4000);

                    }
                    else {
                        hideLoading();
                        toastr.error("هناك خطأ  أثناء إرسال أمرك...فضلا حاول لاحقا.", "خطأ", { timeOut: 60000, rtl: true, closeButton: true, positionClass: 'toast-top-center' }); hideLoading();
                    }
                }); }
        }
        $(document).ready(function () {
            $("#chuu-owl").owlCarousel({

                navigation: true, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                singleItem: true
            });



            $(".owl-prev").addClass("fa");
            $(".owl-prev").addClass("fa-chevron-left");
            $(".owl-prev").text("");

            $(".owl-next").addClass("fa");
            $(".owl-next").addClass("fa-chevron-right");
            $(".owl-next").text("");



        });
    </script>
</asp:Content>
