<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="request-details.aspx.cs" Inherits="Khadmatcom.clients.request_details" %>

<%@ Import Namespace="Khadmatcom.Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/Content/cridet-card.css" rel="stylesheet" />
    <style>
        .modal-body .body {
            min-height: 180px;
        }

        #accordion500 textarea {
            width: 100%;
        }

        .same-div {
            padding-right: 0px;
            padding-left: 0px;
            display: block;
            width: 100%;
        }

        @media (max-width:992px) {
            .same-div {
                float: right;
                padding-right: 20px;
            }
        }

        .b-ac {
            background: url(/images/radio-bg.jpg) no-repeat scroll bottom left;
            background-size: 100% 100%;
            width: 100%;
        }

        .myss label {
            margin-left: 5px;
        }

        .rounded {
            float: left;
            font-size: 1.0em;
            padding: 0px 15px;
        }
    </style>
    <script src="/Scripts/jquery-2.2.3.min.js"></script>
    <script>function payOnline() {
                var amount = <%=Convert.ToDouble(CurrentRequest.CurrentPrice.Value)*1.025%>;
            var transactionId= <%= CurrentRequest.Id %>;
            var userIp= '<%= Servston.Utilities.GetCurrentClientIPAddress() %>';

            var userData = {
                amount: amount,
                transactionId: transactionId,
                attempt: 1,
                userIp: userIp
            };
            $.getJSON("/api/Khadmatcom/Checkout", userData, function (res) {
                showLoading();
                if (res&&res.length> 1) {
                    hideLoading();
                    <%-- var script = document.createElement("script");
                    script.setAttribute("type", "text/javascript");
                    script.setAttribute("src", "<%= HyperPayClient.MerchantConfiguration.Config.Url+"v1/paymentWidgets.js?checkoutId="%>"+res);
                    document.getElementsByTagName("head")[0].appendChild(script);--%>
                    $('#onLinePaymentModal').on('shown.bs.modal', function() { //correct here use 'shown.bs.modal' event which comes in bootstrap3
                        $(this).find('iframe').attr('src', '<%= HyperPayClient.MerchantConfiguration.Config.AmaUrl %>'+"?cid="+res);
                    });
                    $("#onLinePaymentModal").modal({backdrop: 'static',show:true});
                }
                else {
                    hideLoading();
                    toastr.error("هناك خطأ  أثناء إرسال طلبك...فضلا حاول لاحقا.", "خطأ"); hideLoading();
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">تفاصيل الطلب</a></li>
    </ul>
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa">&nbsp;</i><%= CurrentUser.FullName %></h1>
        </div>
        <div class="modal-body">

            <ul class="nav nav-tabs nav-arow myTab" id="ai">
                <!--   <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse500">بيانات الخدمة</a></li> -->
                <li class="active"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse501">المرفقات</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse502">العنوان</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse503">الدفع</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse504">ملخص الطلب</a></li>

            </ul>
            <div class="clearfix"></div>
            <button type="button" style="padding: 3px; opacity: 1; color: red; border-color: #2e6da2; border-width: 2px;" class="btn btn-default disabled text-success pull-left"><span style="display: inline-block;">ريال</span> &nbsp;<span style="display: inline-block;">سعر الخدمة النهائى : <%= ServicePrice %> </span></button>
            <%--    <a class="accordion-toggle indicator collapsed" data-toggle="collapse" data-parent="#accordion500" href="#collapse500" aria-expanded="false">Characteristic of your services from the rest of institutions that provide the same services? <i class="indi fa fa-chevron-down"></i>
                        </a>--%>
            <div class="clearfix"></div>
            <div class="accordion clearfix" id="accordion500">
                <!--
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading ">Service Request &nbsp;  <%= CurrentRequest.MemberId %> <i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse500" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6 col-xs-12 form-group arabic-r">

                                <div class="same-div">
                                    <label>رقم الطلب.</label>
                                    <span class="fixed-no"><%= CurrentRequest.Id %></span>
                                </div>
                                <div class="same-div">
                                    <label>نوع الخدمة.</label>
                                    <span class="fixed-no"><%=string.Format(" {0} -> {1}-> {2}",CurrentRequest.Service.ServiceSubcategory.ServiceCategory.LocalizedServiceCategories.First(l=>l.LanguageId==LanguageId).Title, CurrentRequest.Service.ServiceSubcategory.LocalizedServiceSubcategories.First(l=>l.LanguageId==LanguageId).Title,CurrentRequest.Service.LocalizedServices.First(l=>l.LanguageId==LanguageId).Title) %></span>
                                </div>
                                <%-- <div class="same-div">
                                    <label>service type</label>
                                    <select class="s1">
                                        <option>Web Design</option>
                                        <option>Web Design</option>
                                    </select> 
                                </div>
                                <div class="same-div">
                                    <label>the number</label>
                                    <select class="s2">
                                        <option>1</option>
                                        <option>2</option>
                                    </select>
                                </div>--%>
                                <div class="same-div">
                                    <label>العدد.</label>
                                    <span class="fixed-no"><%= CurrentRequest.Count%></span>
                                </div>
                                <div class="clearfix"></div>
                                <div class="same-div">
                                    <label>تاريخ الطلب.</label>
                                    <span class="fixed-no"><%= CurrentRequest.RequestDate.ToString("MMMM d, yyyy")%></span>
                                </div>

                            </div>
                            <div class="col-md-6 col-xs-12 form-group arabic-r">
                                <div class="same-div">
                                    <label>التفاصيل</label>
                                    <textarea rows="5" disabled="disabled"><%= CurrentRequest.Details%></textarea>
                                </div>
                            </div>
                            <div class="col-md-12 col-xs-12 form-group arabic-r">
                                <div class="same-div">
                                    <asp:Repeater runat="server" ItemType="Khadmatcom.Data.Model.RequestsOptionsAnswer" SelectMethod="GetAnswers">
                                        <ItemTemplate>
                                            <div class="col-md-6">
                                                <div class="input-group">
                                                    <label><%# Item.RequestOption.Title %></label>
                                                    <span class=""><%# GetAnswer(Item.Value) %></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <div class="col-md-12 col-sm-12 ag-1">
                                <%--  <a href="#" class="righttag">Please register for the follow - up steps</a>--%>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="nxt clasic-btn pull-right">التالي</a>
                            </div>
                        </div>
                    </div>
                </div>
                -->
                <div class="panel">
                    <div class="clearfix fal">
                        <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" aria-expanded="false">
                            <div class="accordion-heading">المرفقات <i class="indi fa fa-chevron-up"></i></div>
                        </a>
                    </div>
                    <div id="collapse501" class="collapse" aria-expanded="false"  check="false">
                        <div class="accordion-body clearfix">
                            <div class="row">
                                <div class=" col-md-6  col-sm-6 form-group pull-right">
                                    <label>المرفق 1</label>
                                    <input type="file" class="form-control hidden" />
                                    <asp:FileUpload ID="fup1" runat="server" CssClass="attach form-control" />
                                </div>
                                <div class=" col-md-6  col-sm-6 form-group pull-right">
                                    <label>المرفق 2</label>
                                    <input type="file" class="form-control hidden" />
                                    <asp:FileUpload ID="fup2" runat="server" CssClass="attach form-control" />
                                </div>
                                <div class=" col-md-6  col-sm-6 form-group pull-right">
                                    <label>المرفق 3</label>
                                    <input type="file" class="form-control hidden" />
                                    <asp:FileUpload ID="fup3" runat="server" CssClass="attach form-control" />
                                </div>
                                <div class=" col-md-6  col-sm-6 form-group pull-right">
                                    <label>المرفق 4</label>
                                    <input type="file" class="form-control hidden" />
                                    <asp:FileUpload ID="fup4" runat="server" CssClass="attach form-control" />
                                </div>
                            </div>

                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 form-group">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" class="nxt clasic-btn">التالي</a><span>&nbsp; &nbsp; &nbsp;</span>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse500" class="prv s-cl clasic-btn">السابق</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" aria-expanded="false">
                            <div class="accordion-heading">العنوان<i class="indi fa fa-chevron-up"></i></div>
                        </a>
                    </div>
                    <div id="collapse502" class="collapse validationEngineContainer" aria-expanded="false" check="true">
                        <div class="accordion-body clearfix">
                            <div class="col-md-12">
                                <div class="form-group pull-right col-md-6">
                                    <label>اسم المرسل اليه</label>
                                    <input type="text" class="attach form-control" runat="server" id="txtShippingName" />
                                </div>
                                <div class="form-group pull-right col-md-6">
                                    <label>العنوان</label>
                                    <input type="text" class="attach form-control" runat="server" id="txtShippingAddress" />
                                </div>
                                <div class="form-group pull-right col-md-6">
                                    <label>رقم الجوال</label>
                                    <input type="text" class="attach form-control" runat="server" id="txtShippingPhone" />
                                </div>
                                <div class="form-group pull-right col-md-6">
                                    <label>المدينة</label>
                                    <input type="hidden" id="hfCityId" name="hfCityId" value="" />
                                    <select class="form-control validate[required]" id="ddlCities" onchange="$('#hfCityId').val($('#ddlCities').val());">
                                        <option value="">أختر محافظة</option>
                                        <asp:Repeater runat="server" ItemType="Khadmatcom.Services.Model.Region" SelectMethod="GetRegions">
                                            <ItemTemplate>
                                                <optgroup label="<%# Item.Name %>">
                                                    <asp:Repeater runat="server" ItemType="Khadmatcom.Services.Model.City" DataSource="<%# Item.Cities %>">
                                                        <ItemTemplate>
                                                            <option value="<%# Item.CityId %>"><%# Item.Name %></option>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </optgroup>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </select>
                                </div>

                            </div>

                            <div class="clearfix">&nbsp;</div>
                           
                            <div class="col-md-12 form-group">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="nxt clasic-btn">التالي</a><span>&nbsp; &nbsp; &nbsp;</span>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="prv s-cl clasic-btn">السابق</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" aria-expanded="false">
                            <div class="accordion-heading">الدفع<i class="indi fa fa-chevron-up"></i></div>
                        </a>
                    </div>
                    <div id="collapse503" class="collapse validationEngineContainer" aria-expanded="false" check="true">
                        <div class="accordion-body clearfix validationEngineContainer" id="divServiceRequest">
                            <div class="col-md-12">
                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="1" id="onLineOption" class="validate[required] " /><span>بطاقة الإتمان</span></label>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-6">

                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="2" id="offLineOption" class="validate[required]" /><span>تحويل بنكي</span></label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card1">


                                <div class="form-group col-md-12 col-sm-12 col-xs-12 ">
                                    <div class="text-center visa-img">
                                        <img class="img-responsive pull-right" src="/images/visa-bg.jpg" />

                                        <%-- <select class="form-control validate[required]" name="paymentBrand" runat="server" ID="ddlPaymentBrand">
                                            <option value="VISA">Visa</option>
                                            <option value="MASTER">Master Card</option>
                                            <option value="AMEX">American Express</option>
                                        </select>--%>
                                    </div>
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-12 pull-right hidden">
                                    <label dir="rtl">اسم حامل الكارت</label>
                                    <input type="text" class="attach form-control" runat="server" id="txtCardHolder" />
                                </div>

                                <div class="form-group col-md-6 col-sm-6 col-xs-12 pull-right hidden">
                                    <label dir="rtl">رقم الكارت</label>
                                    <input type="text" class="attach validate[required] form-control" runat="server" id="txtCardNo" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-6 hidden">
                                    <label dir="rtl">CVV</label>
                                    <input type="text" maxlength="3" class="attach validate[required] form-control" name="cars" value="" runat="server" id="txtCvv" />
                                </div>


                                <div class="form-group col-md-6 col-sm-6 col-xs-6 pull-right hidden">
                                    <label dir="rtl">تاريخ صلاحية الكارت</label>
                                    <input type="text" name="txtExpiryDate" class="form-control" id="txtExpiryDate" runat="server" maxlength="5" placeholder="mm/yy" />
                                </div>

                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card2">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="form-group col-md-4 col-sm-4  col-xs-4 pull-right">
                                        <img class="img-responsive " src="/images/rajhi.png" />
                                    </div>
                                    <div class="form-group col-md-4  col-sm-4  col-xs-4 pull-right">
                                        <img class="img-responsive " src="/images/Riyadh.png" />
                                    </div>
                                    <div class="form-group col-md-4 col-sm-4  col-xs-4 pull-right">
                                        <img class="img-responsive" src="/images/Ahli.png" />
                                    </div>
                                </div>
                                <div class="col-md-6  col-sm-6 col-xs-6 form-group pull-right">
                                    <label dir="rtl">رقم الحوالة(العملية)</label>
                                    <input type="text" class="attach validate[required] form-control" runat="server" id="txtRefNumber" />
                                </div>

                                <div class="col-md-6  col-sm-6 col-xs-6 form-group pull-right">
                                    <label dir="rtl">رقم الحساب البنكي المحول منه</label>
                                    <input type="text" class="attach validate[required] form-control" runat="server" id="txtBakAccountNum" />
                                </div>

                                <div class="form-group col-md-6  col-sm-6 col-xs-6 pull-right">
                                    <label dir="rtl">تاريخ التحويل</label>
                                    <input type="text" class="attach validate[required] datetimepicker form-control" id="txtDate" runat="server" maxlength="10" placeholder="dd/mm/yyyy" />
                                </div>
                                <%--<div class="form-group">
                                        <label>تاريخ التحويل</label>
                                        <input type="text" class="attach" />
                                    </div>--%>





                                <div class="col-md-6  col-sm-6 col-xs-6 form-group pull-right">
                                    <label dir="rtl">البنك المحول اليه</label>
                                    <select class="attach validate[required] form-control" runat="server" id="ddlBanks">
                                        <option value="">اختر البنك</option>
                                        <option value="1">الراجحي</option>
                                        <option value="2">الأهلي</option>
                                        <option value="3">الرياض</option>
                                        <option value="8">سامبا </option>

                                    </select>
                                </div>



                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 rtl">
                                <table style="width: 100%;" border="1" cellpadding="20" class="table myss">
                                    <tr>
                                        <td>
                                            <label dir="rtl">الإجمالى: </label>
                                            <span class="rounded"><span style="display: inline-block;">ريال</span>&nbsp; <%= CurrentRequest.CurrentPrice.Value %> </span>
                                        </td>
                                        <td>
                                            <label dir="rtl">تكلفة الشحن:</label>
                                            <span class="ga"><span style="display: inline-block;">ريال</span>&nbsp; <%= ShippingPrice %></span>
                                        </td>
                                        <td>
                                            <label dir="rtl">قيمة الخدمة:</label>
                                            <span class="ga"><span style="display: inline-block;">ريال</span>&nbsp; <%= ServicePrice %></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 form-group clearfix">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse504" class="nxt clasic-btn" id="pay">التالي</a><span>&nbsp; &nbsp; &nbsp;</span> <%--onclick="return checkPaymentSection()"--%>
                                <%--<a href="card-info.aspx" class="nxt s-cl clasic-btn">Pay Now</a>--%>
                                <%-- <a data-toggle="collapse" data-parent="#accordion500" href="card-info.aspx" class="app-close s-cl clasic-btn">Pay Later</a>--%>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" class="prv s-cl clasic-btn">السابق</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <a data-toggle="collapse" data-parent="#accordion500" href="#collapse504" aria-expanded="false">
                            <div class="accordion-heading">ملخص الطلب <i class="indi fa fa-chevron-up"></i></div>
                        </a>
                    </div>
                    <div id="collapse504" class="collapse validationEngineContainer" check="false" aria-expanded="false">
                        <div class="accordion-body clearfix" id="submitServiceRequest">
                            <div class="form-group col-md-12" style="min-height: 50px;"><%= Summary %></div>
                             <div class="form-group col-md-12">
                                <label class="checkbox form-label">
                                    <input type="checkbox"  class="validate[required]" id="chkAgree" checked="checked" />
                                    <span>أوافق على  <a class="btn-link" href='<%= GetLocalizedUrl("info/use-agreement") %>' target="_blank">سياسة إستخدام الموقع</a></span>

                                </label>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-12 form-group clearfix">
                                <asp:LinkButton Text="إرسال" runat="server" CssClass="nxt s-cl clasic-btn" ID="btnSave" OnClick="btnSave_OnClick" OnClientClick="return valdit()" />
                                <%--<a href="#" class="nxt s-cl clasic-btn">Proceed</a>--%>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="prv s-cl clasic-btn">السابق</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="onLinePaymentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header modal-header-success">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times" aria-hidden="true"></span></button>
                    <h1 class="hidden"><i class="fa">&nbsp;</i></h1>
                </div>
                <div class="modal-body">

                    <iframe class="iframePayment" frameborder="0" allowfullscreen="true" width="100%" style="min-height: 300px;"></iframe>

                </div>
                <div class="modal-footer">
                    <small>ونود إحاطتكم علما انه فى حال دفع قيمة الخدمة عن طريق الفيزا او الماستر كارد سيتم احتساب رسوم إضافية قدرها 2.5% من قبل البنك</small>
                    <button type="button" class="btn btn-default pull-left hidden" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <asp:HiddenField ID="hfCardBrand" runat="server" />
    <asp:HiddenField ID="hfChecked" runat="server" Value="0" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/jquery.creditCardValidator.js"></script>
    <script>
        var defaultClasses = 'attach validate[required]';
        $(document).ready(function () {
            $("#accordion500").on('show.bs.collapse', valdit);
            $("#txtExpiryDate").mask("99/99");    
            // $('input#txtCardNo').validateCreditCard(function(result) {
            //   $("#hfCardBrand").val(result.card_type == null ? '-' : result.card_type.name);
            // $("#hfCardBrandValid").val(result.valid);
            //$('.log').html('Card type: ' + (result.card_type == null ? '-' : result.card_type.name)
            //         + '<br>Valid: ' + result.valid
            //         + '<br>Length valid: ' + result.length_valid
            //         + '<br>Luhn valid: ' + result.luhn_valid);
            //});
            $(".myTab a").click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });

            $(".datetimepicker").mask("99/99/9999");  
            //$('.datetimepicker').datetimepicker({
            //    locale: 'ar'
            //});
            $('input#txtCardNo').keyup(function() {
                var cardResult = $('input#txtCardNo').validateCreditCard({ accept: ['visa', 'mastercard'] });//
                var cardType = cardResult.card_type == null ? '-' : cardResult.card_type.name;

                $('input#txtCardNo').attr('class',defaultClasses+' '+cardType);
                $("#hfCardBrand").val(cardType);
                
            });
        });

        function valdit() {
            var check = $('#accordion500 .in').attr('check');
            
            var doCheck = $('#hfChecked').val();
            if (check == 'false') {
                $('#hfChecked').val('0');
                return true;
            } else {
                if (doCheck == '0') {
                    var id = $('#accordion500 .in').attr("id");
                   var result = validateForm('#' + id, '<%= System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName.ToLower() %>');
                    return result;
                }
                return true;
            }
        }

        function ValditPaymentSection() {
                var result = false;
                result=validateForm('#divServiceRequest', '<%# languageIso %>');
            if(result)
            {
                var cardResult = $('input#txtCardNo').validateCreditCard({ accept: ['visa', 'mastercard'] });//
                var cardType = cardResult.card_type == null ? '-' : cardResult.card_type.name;
                if(cardType  !== '-')$('input#txtCardNo').addClass(cardType);
                $("#hfCardBrand").val(cardType);
                
                result = cardResult.valid;
                return result;//result;
            }return result;//result;
        }
       
            //var paymentSection = false;

            //  function checkPaymentSection() {
            //     paymentSection=validateForm('#divServiceRequest', '<%# languageIso %>');
            //  }
            function checkPayment() {
                var result = false;
                result=validateForm('#divServiceRequest', '<%# languageIso %>');
                var onLineOption = false;
                onLineOption = $('#onLineOption').is(':checked');//$('#onLineOption').attr('checked') == "checked";
                if (result && onLineOption) {
                    //result = false;
                    //payOnline();
                }
                //  if (paymentSection != result)
                //      return paymentSection;
                return result;
            }
    </script>
</asp:Content>
