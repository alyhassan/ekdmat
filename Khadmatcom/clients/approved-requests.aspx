﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="approved-requests.aspx.cs" Inherits="Khadmatcom.clients.approved_reuests" %>

<%@ Import Namespace="Khadmatcom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">طلبات وبإنتظار الدفع</a></li>
    </ul>
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
        <asp:ListView runat="server" ID="lvServiceRequest" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="3" ItemType="Khadmatcom.Data.Model.ServiceRequest">
            <GroupTemplate>
                <div class="item">
                    <div class="accordion clearfix" id="accordion4">
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
                                    <span>نوع الخدمة:<span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"subcategory") %></span> </span>
                                    <span>العدد:<span class="blue"><%# Item.Count%></span> </span>
                                </div>
                                <div class="L2">
                                    :تفاصيل الخدمة
                                </div>
                                <div class="L3 blue">
                                    <p>
                                        <%# Item.Details %>
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right<%# Item.Id %>" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix" dir="rtl" style="direction: rtl; padding: 5px;">
                            <div class="list-group L-container">
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" DataSource='<%# Item.RequestsOptionsAnswers %>'>
                                    <ItemTemplate>
                                        <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                            <div class="input-group">
                                                <label class="list-group-item-heading blue"><i class="fa fa-arrow-circle-o-left blue" aria-hidden="true"></i><%# Item.RequestOption.Title %></label>:
                                                 &nbsp;
                                                <label><%# GetAnswer(Item.Value) %></label>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="list-group L-container">
                                <div class="col-md-6 pull-right">
                                    <div class="input-group">
                                        <i class="fa fa-arrow-circle-o-left blue" aria-hidden="true"></i>&nbsp; 
                                     <label class="blue">مدة التنفيذ</label>:&nbsp; 
                                     <span class=""><%# Item.CurrentDuration %></span>&nbsp;<span>يوم</span>
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <!-- <div class="input-group"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>&nbsp; 
                                      <label>ثمن الخدمة</label>:&nbsp; 
                                      <span class=""><%# Item.CurrentPrice %></span>
                                      </div>-->

                                    <div class="input-group">
                                        <i class="fa fa-pencil-square-o blue" aria-hidden="true"></i>&nbsp; 
                                <label class="blue">تعليق</label>:&nbsp; 
                                <span class=""><%# Item.Notes %></span>
                                    </div>
                                </div>
                            </div>
                            <!-- <div class="col-md-12">
                                  <div class="input-group"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; 
                                <label>  تعليق</label>:&nbsp; 
                                <span class=""><%# Item.Notes %></span>
                                 </div>
                            </div> -->

                            </p>
                           <div class="clearfix"></div>
                            <div class="L-button" id="">
                                <a href="<%# GetLocalizedUrl(string.Format("clients/services-requests/{0}/request-details",Item.Id.EncodeNumber())) %>" class='<%# Item.Service.SkipPayment?"hidden":"editt" %>'>إكمال الطلب</a>
                                <input type="button" class='<%# Item.Service.SkipPayment?"btn btn-success  btn-sm":"hidden" %>' value="تم التأكيد" onclick="approveRequest(<%# Item.Id %>);" />
                            </div>
                            <button type="button" style="padding: 3px; opacity: 1; color: green;" class="btn btn-default disabled text-success pull-left">سعر الخدمة : <%# Item.CurrentPrice %> <span style="display: inline-block;">ريال</span> </button>

                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/carousel-js/owl.carousel.js"></script>
    <script src="/Scripts/carousel-js/owl.carousel.min.js"></script>
    <script type="text/javascript">
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

        function approveRequest(id) {
            var result = validateForm('#increase' + id, '<%= languageIso %>');
            //do what you need here
            if (result) {
                var userData = {
                    id: id,
                    dummy:false,
                    x:0
                };
                $.getJSON("/api/Khadmatcom/ConfirmRequest", userData, function (res) {
                    showLoading();
                    if (res) {
                        hideLoading();
                        toastr.success("تم تأكيد طلبك", "شكرا لك",{timeOut: 6000,rtl:true,closeButton:true,positionClass:'toast-top-center'});
                    }
                    else {
                        result = false;
                        hideLoading();
                        toastr.error("هناك خطأ  أثناء تأكيد طلبك...فضلا حاول لاحقا.", "خطأ",{timeOut: 6000,rtl:true,closeButton:true,positionClass:'toast-top-center'}); 
                    }
                });

            }
            return result;
        }
    </script>
</asp:Content>
