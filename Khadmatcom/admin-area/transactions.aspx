<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="transactions.aspx.cs" Inherits="Khadmatcom.admin_area.transactions" %>

<%@ Import Namespace="Khadmatcom" %>
<%@ Import Namespace="Khadmatcom.Data.Model" %>
<%@ Import Namespace="Khadmatcom.Services" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub alif"><a href="javascript:{}">العمليات</a></li>
        <li class="sub active alif"><a href="javascript:{}"><%= GetGlobalResourceObject("general.aspx",CurrentStatus.ToString()) %></a></li>
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
                                    <span>نوعها:<span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"subcategory") %></span> </span>
                                    <span>العدد:<span class="blue"><%#Item.Count %></span> </span>
                                </div>
                                <div class="L1">
                                    <span class="ni">اسم العميل: <span class="red"><%# Item.Client.FullName %></span> </span>
                                    <span>رقم الجوال: <span class="blue"><%# Item.Client.MobielNumber %></span> </span>
                                    <span>المدينة: <span class="blue"><%# Item.City1.LocalizedCities.First(l=>l.LanguageId==3073).Title %></span> </span>
                                    <span <%# Item.StatusId>=(int)RequestStatus.InProgress&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":" class='hidden'" %>><span style="display:inline-block;">رقم الحساب: </span><span class="blue" style="display:inline-block;"><%# Item.PaymentReferanceCode %></span>
                                    </span>
                                </div>

                                <div class="clearfix"></div>
                                <div<%# Item.StatusId>=(int)RequestStatus.New&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":" class='hidden'" %>>
                                <div class="row L2">
                                    <div class="col-md-12 col-sm-12 col-xs-12 pull-right;">
                                        تفاصيل الخدمة :
                                    </div>
                                </div>
                                <div class="L3 blue">
                                    <p>
                                        <%# Item.Details %>
                                    </p>
                                </div>
                            </div>
                    </div>

                    </a>

                </div>
                <div id="right<%# Item.Id %>" class="collapse" aria-expanded="false">
                    <div class="accordion-body clearfix" dir="rtl" style="direction: rtl;">
                        <div class="list-group L-container">
                            <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" DataSource='<%# Item.RequestsOptionsAnswers %>'>
                                <ItemTemplate>
                                    <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                        <div class="input-group">
                                            <label class="list-group-item-heading blue"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>&nbsp;<%# Item.RequestOption.Title %></label>
                                            &nbsp;<label><%# GetAnswer(Item.Value) %></label>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <div <%# Item.StatusId>=(int)RequestStatus.Approved&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":"class='hidden'" %>>

                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading blue"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>السعر النهائي</label>
                                        :
                                                       &nbsp; <span class=""><%# GetPrice(Item).ToCurrency("ريال") %> </span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading blue"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>مدة التنفيذ</label>
                                        :
                                                       &nbsp; <span class=""><%# Item.TotalDuration %> يوم</span>
                                    </div>
                                </div>
                            </div>
                            <div <%# Item.StatusId>=(int)RequestStatus.InProgress&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":"class='hidden'" %>>


                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading blue"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>طريقة الدفع</label>
                                        :
                                                       &nbsp; <span class=""><%# GetPaymentMethod(Item.PaymentMethod) %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading blue"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>اسم شريك الخدمة </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.CurrentProvider.HasValue? Item.Provider.FullName :"-"%></span>
                                    </div>
                                </div>

                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading blue"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>رقم الجوال </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.CurrentProvider.HasValue?Item.Provider.MobielNumber :"-" %></span>
                                    </div>
                                </div>
                                <hr />

                            </div>
                            <div>
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestProvider" DataSource='<%# Item.RequestProviders %>'>
                                <ItemTemplate>
                                    <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                        <div class="input-group">
                                            <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>&nbsp;<%# Item.User.FullName%></label>
                                            &nbsp;<label><%# (RequestStatus)Item.Status %></label><br/><label><%# Item.ExpiryTime %></label>
                                         <div class="clearfix" ></div>
                                                <div class="input-group">
                                                <label class="list-group-item-heading blue"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>تعليق: </label>
                                              <span> <%# Item.RejectedReson %></span> 

                                               </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            </div>
                            

                            <%--المرفقات--%>
                            <div <%# Item.StatusId>=(int)RequestStatus.New&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":"class='hidden'" %>>
                                <hr />
                                <asp:ListView runat="server" DataSource="<%# Item.Attachments.Where(x=>x.IsOutput==false) %>" ItemType="Khadmatcom.Data.Model.Attachment">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# string.Format("/Attachments/{0}", Item.Path)%>'>المرفق <%# Container.DataItemIndex+1 %></a>
                                    </ItemTemplate>
                                    <ItemSeparatorTemplate>, </ItemSeparatorTemplate>
                                </asp:ListView>
                            </div>

                            <div <%# Item.StatusId>=(int)RequestStatus.Accomplished&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"":"class='hidden'" %>>
                                <hr />
                                <asp:ListView runat="server" DataSource="<%# Item.Attachments.Where(x=>x.IsOutput==true) %>" ItemType="Khadmatcom.Data.Model.Attachment">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# string.Format("/Attachments/{0}", Item.Path)%>'>المرفق <%# Container.DataItemIndex+1 %></a>
                                    </ItemTemplate>
                                    <ItemSeparatorTemplate>, </ItemSeparatorTemplate>
                                </asp:ListView>
                            </div>

                            <div class='<%# Item.StatusId>=(int)RequestStatus.Accomplished&&(Item.StatusId!=(int)RequestStatus.Refused||Item.StatusId!=(int)RequestStatus.Expired||Item.StatusId!=(int)RequestStatus.Canceled)?"col-md-6 col-sm-6 col-xs-12 pull-right":"hidden" %>'>
                                <hr />
                                <div class="input-group">
                                    <label class="list-group-item-heading"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>ملاحظات: </label>
                                    :
                                                       &nbsp; <span class=""><%# Item.Notes  %></span>
                                </div>
                            </div>
                        </div>
                        <div class="L-button" id="">
                            <button type="button" style="padding: 3px; opacity: 1; color: green;" class="btn btn-default disabled text-success ">حالة الطلب:<%# (RequestStatus)Item.StatusId %>&nbsp;<span style="display: inline-block; float: left"></span>&nbsp;  </button>
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
