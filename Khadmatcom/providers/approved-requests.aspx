<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="approved-requests.aspx.cs" Inherits="Khadmatcom.clients.approved_reuests" %>
<%@ Import Namespace="Khadmatcom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
   <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">خدمات بإنتظار الدفع</a></li>
    </ul> <div id="chuu-owl" class="chuu owl-carousel owl-theme">
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
                                    <span>نوعها:<span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"subcategory") %></span> </span>
                                </div>
 <div class="clearfix"></div>
                                <div class="row L2">
                                    <div class="col-md-12 col-sm-12 col-xs-12 pull-right;">
                                    :تفاصيل الخدمة
                                      </div>
                                </div>
                                <div class="row L3">
                                    <p>
                                        <%# Item.Details %>
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right<%# Item.Id %>" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix" dir="rtl" style="direction: rtl;" >
                            <div class="list-group L-container">
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" DataSource='<%# Item.RequestsOptionsAnswers %>'>
                                            <ItemTemplate>
                                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                                    <div class="input-group">
                                                        <label><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i><%# Item.RequestOption.Title %></label>
                                                        <label><%# GetAnswer(Item.Value) %></label>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                            </div>
                            <div class="L-button hidden" id="">
                                <a href="<%# GetLocalizedUrl(string.Format("providers/services-requests/{0}/request-details",Item.Id.EncodeNumber())) %>" class="editt">Edit</a>
                            </div>

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
    </script>
</asp:Content>