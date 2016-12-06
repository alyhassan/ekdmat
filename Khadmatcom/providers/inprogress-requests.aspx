<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="inprogress-requests.aspx.cs" Inherits="Khadmatcom.providers.inprogress_requests" %>

<%@ Import Namespace="Khadmatcom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">خدمات تحت التنفيذ</a></li>
    </ul>
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
        <asp:ListView runat="server" ID="lvServiceRequest" OnItemCommand="lvServiceRequest_OnItemCommand" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="3" ItemType="Khadmatcom.Data.Model.ServiceRequest">
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
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" DataSource='<%# Item.RequestsOptionsAnswers %>'>
                                    <ItemTemplate>
                                        <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                            <div class="input-group">
                                                <label><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>&nbsp;<%# Item.RequestOption.Title %></label>
                                                &nbsp;<label><%# GetAnswer(Item.Value) %></label>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>مدة التنفيذ</label>
                                        :
                                                       &nbsp; <span class=""><span class=""><%# Item.TotalDuration %> يوم</span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>طريقة الدفع</label>
                                        :
                                                       &nbsp; <span class=""><%# GetPaymentMethod(Item.PaymentMethod) %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                    <div class="input-group">
                                        <label class="list-group-item-heading"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>تعليق </label>
                                        :
                                                       &nbsp; <span class=""><%# Item.Notes %></span>
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-12 pull-right">
                                  <label class="list-group-item-heading pull-right"><i class="fa fa-arrow-circle-o-left" aria-hidden="true"></i>المرفقات</label>
                                <asp:ListView runat="server" DataSource="<%# Item.Attachments.Where(x=>x.IsOutput==false) %>" ItemType="Khadmatcom.Data.Model.Attachment">
                                    <ItemTemplate>
                                        <a target="_blank" href='<%# string.Format("/Attachments/{0}", Item.Path)%>'>المرفق <%# Container.DataItemIndex+1 %></a>
                                    </ItemTemplate>
                                    <ItemSeparatorTemplate>, </ItemSeparatorTemplate>
                                </asp:ListView>
                                    </div>
                            </div>
                           
                      
                            <div class="L-button" id="">
                                <div class="L-button">
                                <button type="button" style="padding: 3px; opacity: 1; color: green;" class="btn btn-default disabled text-success ">سعر الخدمة:<%# Item.RequestProviders.First(x=>x.ProviderId==CurrentUser.Id).Price %>&nbsp;<span style="display: inline-block; float: left">ريال</span>&nbsp;  </button>
                                &nbsp; 
                            </div>
                                <div class="input-group" id="s<%# Item.Id %>">
                                  
                                    <input type="hidden" id="hasAttachment<%# Item.Id %>" value="<%# Item.Service.HasAttachment? 1:0 %>" />
                                    <input type="button" class="btn btn-danger  btn-sm" value="إنهاء الطلب" onclick="finishRequest(<%# Item.Id %>);" />&nbsp;
                                    <input type="button" class="btn btn-success btn-sm" value="تمديد الطلب" onclick="increaceDuration(<%# Item.Id %>);" />&nbsp;

                                </div>
                                <div class="input-group hidden validationEngineContainer increaseDiv" id="increase<%# Item.Id %>">

                                    <label for="txtDuration<%# Item.Id %>" id="txtDurationLabel<%# Item.Id %>">وقت التنفيذ الإضافي</label>
                                    <input type="number" id="txtDuration<%# Item.Id %>" class=" validate[required]" value='' />
                                    <input type="button" class="btn btn-success btn-sm" value="إرسال" onclick="increaceRequestDurationAction(<%# Item.Id %>);" />
                                    <%--<asp:Button Text="إرسال" OnClientClick="return increaceRequestDurationAction(<%# Item.Id %>);" OnClick="OnClick" CssClass="btn btn-success btn-sm" runat="server" CommandName="Update" CommandArgument="<%# Item.Id %>" />--%>
                                </div>

                                <a href="<%# GetLocalizedUrl(string.Format("providers/services-requests/{0}/request-details",Item.Id.EncodeNumber())) %>" class="editt hidden">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:ListView>

    </div>
    <asp:HiddenField ID="currentId" runat="server" ClientIDMode="Static" />
    <div class="modal fade" id="attachmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-success">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    <h1 class="hidden"><i class="fa">&nbsp;</i></h1>
                </div>
                <div class="modal-body validationEngineContainer" id="attachmentContainer">
                    <div class="row">
                        <div class="col-md-6 form-group pull-right">
                            <label for=""></label>
                            <asp:FileUpload ID="fupAttachment" ClientIDMode="Static" runat="server" CssClass="attach validate[required]" AllowMultiple="True" />
                        </div>
                        <div class="col-md-12 pull-right">
                            <span><i class="fa fa-signal"></i>&nbsp;الحد الأقصى للملفات المرفوعة هو ا ميجا لكل ملف </span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSave" runat="server" Text="إرسال" CssClass="glyphicon-hdd btn-primary btn btn-sm" OnClientClick="return validateForm('#attachmentContainer', '<%= languageIso %>')" OnClick="btnSave_OnClick" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
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
    <script type="text/javascript">
        function finishRequest(id) {
            var hasAttachment=$('#hasAttachment' + id).val();
            if (hasAttachment == 0) {
                closeRequest(id);
            } else {
                showAttachmentModal(id);
            }
        }

        function showAttachmentModal(id) {
            $('#currentId').val(id);
            $("#attachmentModal").modal({backdrop: 'static',show:true});
        }

        function  closeRequest(id)
        {
            var userData = {
                id: id
            };
            $.getJSON("/api/Khadmatcom/CloseProviderRequest", userData, function (res) {
                $("#p8").modal('hide');
                showLoading();
                if (res) {
                    hideLoading();
                    toastr.success("تم تنفيذ طلبك", "شكرا لك");
                    clearFormData('#txtDuration'+id);
                    location.reload();
                }
                else {
                    hideLoading();
                    clearFormData('#txtDuration'+id);
                    toastr.error("هناك خطأ  أثناء إرسال طلبك...فضلا حاول لاحقا.", "خطأ"); 
                }
            });
        }

        function increaceDuration(id) {
            $(".increaseDiv").addClass('hidden');
            $("#increase" + id).removeClass('hidden');
        }
        function setUploadButtonState() {

            var maxFileSize = 4194304; // 4MB -> 4 * 1024 * 1024
            var fileUpload = $('#fupAttachment');

            if (fileUpload.val() == '') {
                return false;
            }
            else {
                if (fileUpload[0].files[0].size < maxFileSize) {
                    $('#button_fileUpload').prop('disabled', false);
                    return true;
                }else {
                    $('#lbl_uploadMessage').text('File too big !');
                    return false;
                }
            }
        }
        function increaceRequestDurationAction(id) {
            alert(id);
            var result=validateForm('#increase'+id, '<%= languageIso %>')
            //do what you need here
            if (result) {
                var userData = {
                    id: id,
                    duration:$('#txtDuration'+id).val()
                };
                $.getJSON("/api/Khadmatcom/IncreaseProviderRequest", userData, function (res) {
                    showLoading();
                    if (res) {
                        hideLoading();
                        toastr.success("تم تنفيذ طلبك", "شكرا لك");
                        clearFormData('#txtDuration'+id);
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
    </script>
</asp:Content>
