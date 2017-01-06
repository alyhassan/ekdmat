<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Khadmatcom.providers._default" %>

<%@ Import Namespace="Khadmatcom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">خدمات جديدة</a></li>
    </ul>
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
        <asp:ListView runat="server" OnItemCommand="lvServiceRequest_OnItemCommand" ID="lvServiceRequest" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="5" ItemType="Khadmatcom.Data.Model.ServiceRequest">
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
                                    <span>نوعها:<span class="blue"><%# GetServiceInfo(Item.ServiceId,LanguageId,"subcategory") %></span> </span>
                                    <span>الوقت المتبقي للرد:<br />
                                        <span class="blue" dir="ltr"><%# string.Format("{0:dd MMM yyyy HH:mm}",Item.RequestProviders.First(x=>x.ProviderId==CurrentUser.Id).ExpiryTime) %></span> </span>
                                </div>
                                <div class="clearfix"></div>
                                <div class="row L2">
                                    <div class="col-md-12 col-sm-12 col-xs-12 pull-right">
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
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" DataSource='<%# Item.RequestsOptionsAnswers %>'>
                                    <ItemTemplate>
                                        <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                            <div class="input-group">
                                                <label  class="blue"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>&nbsp;<%# Item.RequestOption.Title %></label>
                                                &nbsp;<label><%# GetAnswer(Item.Value) %></label>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <br />

                            <div class="input-group pull-left" id="s<%# Item.Id %>">
                                <input type="button" class="btn btn-danger  btn-sm" value="رفض الطلب" onclick="takeAction(<%# Item.Id %>,6);" />
                                &nbsp;
                                    <input type="button" class="btn btn-success btn-sm" value="قبول الطلب" onclick="takeAction(<%# Item.Id %>,2);" />
                            </div>
                            <div class="form">
                                <div class="input-group hidden validationEngineContainer  form-group col-md-12" id="reason<%# Item.Id %>">
                                    <div class="form-group col-md-12 col-sm-12 col-xs-12">

                                        <input type="text" id="txtReason<%# Item.Id %>" class="validate[required] col-md-12 pull-right form-control" placeholder="تعليق" />
                                    </div>
                                    <div class="form-group col-md-6 col-sm-6 col-xs-6 pull-right">
                                        <label for="txtPrice<%# Item.Id %>" id="txtPriceLabel<%# Item.Id %>" class="  pull-right">سعر الخدمة</label>
                                        <input type="text" id="txtPrice<%# Item.Id %>" class=" validate[required] hidden col-md-4 col-sm-4 col-xs-4 f pull-right form-control" value='<%# Item.RequestProviders.First(r=>r.ProviderId==CurrentUser.Id).Price %>' />
                                    </div>
                                    <div class="form-group col-md-6 col-sm-6 col-xs-6 pull-right">
                                        <label for="txtDuration<%# Item.Id %>" id="txtDurationLabel<%# Item.Id %>" class="pull-right col-md-12">وقت التنفيذ المتوقع</label>
                                     <div class="col-md-12 input-group">  
                                          <input type="text" id="txtDuration<%# Item.Id %>" class=" validate[required] hidden   pull-right form-control" value='' />
                                       <label for="txtDuration<%# Item.Id %>" id="txtDurationLabel<%# Item.Id %>" class="input-group-addon" style="background-color:transparent !important; border:none;">يوم</label>
                                         </div>
   <%--<%# Item.Service.ServiceProviders.First(r=>r.MemberId==CurrentUser.Id).EstamaitedTime %>--%>
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12 col-xs-12 pull-right">
                                        <asp:Button Text="إرسال" OnClientClick="return takeRequestAction();" OnClick="OnClick" CssClass="btn btn-success" runat="server" CommandName="Update" CommandArgument="<%# Item.Id %>" />
                                    </div>
                                </div>
                                <div class="L-button" id="">
                                    <a href="<%# GetLocalizedUrl(string.Format("providers/services-requests/{0}/request-details",Item.Id.EncodeNumber())) %>" class="editt hidden">Edit</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:ListView>

        <input type="hidden" id="status" />

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/carousel-js/owl.carousel.js"></script>
    <script src="/Scripts/carousel-js/owl.carousel.min.js"></script>
    <script type="text/javascript">
        var id;
        var state;
        var duration = 0;
        function takeAction(id1,state1) {
            id = id1;
            state = state1;
            $("#s" + id).addClass('hidden');
            
            $("#txtReason" + id).removeClass('hidden');

            if (state === 2) {
                $("#txtPrice" + id).removeClass('hidden');
                $("#txtPriceLabel" + id).removeClass('hidden');
                $("#txtDuration" + id).removeClass('hidden');
                $("#txtDurationLabel" + id).removeClass('hidden');
            } else {
                $("#txtPrice" + id).addClass('hidden');
                $("#txtPriceLabel" + id).addClass('hidden');
                $("#txtDuration" + id).addClass('hidden');
                $("#txtDurationLabel" + id).addClass('hidden');
            }
            $("#reason" + id).removeClass('hidden');


            $("#status").val(state);
        }

        
        function takeRequestAction() {
            var result = validateForm('#reason'+id, '<%= languageIso %>');
            //do what you need here
            if (result) {
                if( $('#txtDuration' + id).val().length>0)
                    duration = $('#txtDuration' + id).val();

                var userData = {
                    userId: <%= CurrentUser.Id %>,
                    id: id,
                    status: state,
                    duration:duration,
                    price: $('#txtPrice'+id).val(),
                    reason: $('#txtReason'+id).val()
                };

                $.getJSON("/api/Khadmatcom/UpdateProviderRequest", userData, function (res) {
                    showLoading();
                    if (res) {
                        setTimeout(function() {
                            //do what you need here
                            hideLoading();
                            toastr.success("تم تنفيذ أمرك", "شكرا لك", {timeOut: 60000,rtl:true,closeButton:true,positionClass:'toast-top-center'});
                            clearFormData('#txtPrice'+id);
                            clearFormData('#txtReason'+id);
                            clearFormData('#txtDuration'+id);
                        }, 4000);
                        
                    }
                    else {
                        hideLoading();
                        toastr.error("هناك خطأ  أثناء إرسال أمرك...فضلا حاول لاحقا.", "خطأ", {timeOut: 60000,rtl:true,closeButton:true,positionClass:'toast-top-center'}); hideLoading();
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
