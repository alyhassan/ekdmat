<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="provider-rights.aspx.cs" Inherits="Khadmatcom.admin_area.provider_rights" %>

<%@ Import Namespace="Khadmatcom" %>
<%@ Import Namespace="Khadmatcom.Data.Model" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">مستحقات شركائنا</a></li>
    </ul>
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
        <asp:ListView runat="server" ID="lvServiceRequest" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="3" ItemType="Khadmatcom.Data.Model.ServiceRequest">
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
                                    <span>العدد:<span class="blue"><%#Item.Count %></span> </span>
                                </div>
                                <div class="L1">
                                    <span class="ni">اسم العميل: <span class="red"><%# Item.Client.FullName %></span> </span>
                                    <span>رقم الجوال: <span class="blue"><%# Item.Client.MobielNumber %></span> </span>
                                    <span>المدينة: <span class="blue"><%# Item.City1.LocalizedCities.First(l=>l.LanguageId==1025).Title %></span> </span>
                                   
                                </div>

                                <div class="clearfix"></div>
                                <div class="row L2">
                                    <div class="col-md-12 col-sm-12 col-xs-12 pull-right;">
                                        <span class="ni"><span class="red"></span></span>
                                    </div>
                                </div>
                                <div class="L3">
                                    <p>
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
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>اسم شريك الخدمة </label>
                                        :
                                                       &nbsp; <span class=""><%#Item.CurrentProvider.HasValue? Item.Provider.FullName :"-" %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>رقم الجوال </label>
                                        :
                                                       &nbsp; <span class=""><%#  Item.CurrentProvider.HasValue?Item.Provider.MobielNumber :"-" %></span>
                                    </div>

                                </div>
                                 <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>اسم البنك</label>
                                        :
                                                       &nbsp; <span class=""><%# Item.CurrentProvider.HasValue?(Item.Provider.BankAccountType.HasValue?Item.Provider.BankAccountType.Value.ToString():"") :"-" %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>رقم الحساب</label>
                                        :
                                                       &nbsp; <span class=""><%# Item.CurrentProvider.HasValue?Item.Provider.BankAccountNumber :"-" %></span>
                                    </div>
                                </div>
                               <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>المستحق عن الخدمة</label>
                                        :
                                                       &nbsp; <span class=""><%# GetPrice(Item).ToCurrency() %></span>
                                    </div>
                                </div>  

                            </div>
                            <div class="L-button" id="">
                                <button type="button" style="padding: 3px; opacity: 1; color: green;" class="btn btn-default disabled text-success ">حالة الطلب:<%# (RequestStatus)Item.StatusId %>&nbsp;<span style="display: inline-block; float: left"></span>&nbsp;  </button>
                            </div>
                            <div class='<%# string.IsNullOrEmpty(Item.PartnerPaymentCode)?"hidden":"" %>'>
                                <div class="L1">
                                    <span class="ni">رقم الحوالة: <span class="red"><%# Item.PartnerPaymentCode %></span> </span>
                                    <span>تاريخ التحويل: <span class="blue"><%# Item.PartnerPaymentDate %></span> </span>

                                </div>
                            </div>
                            <div class='<%# string.IsNullOrEmpty(Item.PartnerPaymentCode)?"":"hidden" %>'>
                                <div class="input-group" id="s<%# Item.Id %>">

                                    <input type="button" class="btn btn-danger  btn-sm" value="تأكيد التحويل" onclick="transfare(<%# Item.Id %>);" />

                                </div>
                                <div class="input-group hidden validationEngineContainer transfareDiv" id="transfare<%# Item.Id %>">

                                    <label for="txtDuration<%# Item.Id %>" id="txtDurationLabel<%# Item.Id %>">رقم التحويل</label>
                                    <input type="number" id="txtDuration<%# Item.Id %>" class=" validate[required]" value='' />
                                    <input type="button" class="btn btn-success btn-sm" value="تأكيد" onclick="transfareAction(<%# Item.Id %>);" />
                                </div>
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
        function transfare(id) {
            showTtransfareBlock(id);
        }

        function showTtransfareBlock(id) {
            $(".transfareDiv").addClass('hidden');
            $("#transfare" + id).removeClass('hidden');
        }

        function transfareAction(id) {
            var result = validateForm('#transfare' + id, '<%= languageIso %>');
            //do what you need here
            if (result) {
                var userData = {
                    id: id,
                    code:$('#txtDuration'+id).val()
                };
                $.getJSON("/api/KhadmatcomAdmin/Transfare", userData, function (res) {
                    showLoading();
                    if (res) {
                        hideLoading();
                        toastr.success("تم تنفيذ طلبك", "شكرا لك");
                        clearFormData('#txtDuration'+id);
                        window.setTimeout(location.reload(), 30000);//30 second
                    }
                    else {
                        result = false;
                        hideLoading();
                        clearFormData('#txtDuration'+id);
                        toastr.error("هناك خطأ  أثناء إرسال طلبك...فضلا حاول لاحقا.", "خطأ"); 
                    }
                });

            }
            return result;
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
