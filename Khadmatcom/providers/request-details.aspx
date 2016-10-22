<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="request-details.aspx.cs" Inherits="Khadmatcom.providers.request_details" %>

<%@ Import Namespace="Khadmatcom.Services" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}">تفاصيل الخدمة</a></li>
    </ul>
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa">&nbsp;</i>Service Request</h1>
        </div>
        <div class="modal-body">

            <ul class="nav nav-tabs nav-arow myTab" id="ai">
               <!-- <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse500">بيانات الخدمة</a></li> -->
                <li class="active"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse501">المرفقات</a></li>
                <li class="hidden"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse502">بيانات الشحن</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse503">طرق الدفع</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse504">ملخص العملية</a></li>

                <%--<li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse500">Service Req</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse501">Attaching</a></li>
                <li class="hidden"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse502">Shipping</a></li>
                <li class="active"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse503">Payment m</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse504">request det</a></li>--%>
            </ul>
            <%--    <a class="accordion-toggle indicator collapsed" data-toggle="collapse" data-parent="#accordion500" href="#collapse500" aria-expanded="false">Characteristic of your services from the rest of institutions that provide the same services? <i class="indi fa fa-chevron-down"></i>
                        </a>--%>
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
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="nxt clasic-btn">التالي</a>
                            </div>
                        </div>
                    </div>
                </div>
                -->
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading">Attaching documents <i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse501" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Attachments 1</label>
                                    <input type="file" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>Attachments 2</label>
                                    <input type="file" class="attach" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Attachments 3</label>
                                    <input type="file" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>Attachments 4</label>
                                    <input type="file" class="attach" />
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
                        <div class="accordion-heading">بيانات الشحن<i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse502" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>اسم المرسل اليه</label>
                                    <input type="text" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>المدينة</label>
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
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>رقم الجوال</label>
                                    <input type="text" class="attach" runat="server" id="txtShippingPhone" />
                                </div>
                                <div class="form-group">
                                    <label>العنوان</label>
                                    <input type="text" class="attach" runat="server" id="txtShippingAddress" />
                                </div>
                                <%--  <div class="form-group">
                                    <label>Region</label>
                                    <select class="attach">
                                        <option>Choose</option>
                                        <option>2</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Telephone number</label>
                                    <input type="text" class="attach" />
                                </div>--%>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="form-group col-md-12">
                                <label class="checkbox form-label">
                                    <input type="checkbox" name="remember" value="1" class="validate[required]" />
                                    <span style="padding-left: 20px;">أوافق على سياسة إستخدام الموقع </span>

                                </label>
                            </div>
                            <div class="col-md-12 form-group">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse504" class="nxt clasic-btn">التالي</a><span>&nbsp; &nbsp; &nbsp;</span>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="prv s-cl clasic-btn">السابق</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel hidden">
                    <div class="clearfix fal">
                        <div class="accordion-heading lanti200">طرق الدفع<i class="indi fa fa-chevron-down"></i></div>
                    </div>
                    <div id="collapse503" class="collapse in" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="1" /><span>بطاقة الإتمان</span></label>
                                    </div>
                                </div>
                                <div class="col-md-6">

                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="2" /><span>تحويل بنكي</span></label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card1">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label>No. kart</label>
                                            <input type="text" class="attach" />
                                        </div>
                                        <div class="form-group">
                                            <label>password</label>
                                            <input type="text" class="attach" name="cars" value="2" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group text-center visa-img">
                                        <img src="/images/visa-bg.jpg" />

                                    </div>
                                    <div class="form-group">
                                        <label>Telephone number</label>
                                        <input type="text" class="attach" />
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card2">
                                <div class="col-md-6">
                                    <div class="form-group  text-center visa-img">
                                    </div>
                                    <div class="form-group">
                                        <label>تاريخ التحويل</label>
                                        <input type="text" class="attach" id="txtDate" runat="server" />
                                    </div>
                                    <%--<div class="form-group">
                                        <label>تاريخ التحويل</label>
                                        <input type="text" class="attach" />
                                    </div>--%>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="form-group">
                                            <label>رقم الحوالة(العملية)</label>
                                            <input type="text" class="attach" runat="server" id="txtRefNumber" />
                                        </div>
                                        <div class="form-group">
                                            <label>البنك المحول اليه</label>
                                            <select class="attach" runat="server" id="ddlBanks">
                                                <option>اختر البنك</option>
                                                <option value="1">الراجحي</option>
                                                <option value="2">الأهلي</option>
                                                <option value="3">الرياض</option>
                                                <option value="8">سامبا </option>

                                            </select>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12">
                                <table style="width: 100%;" border="1" cellpadding="20" class="table myss">
                                    <tr>
                                        <td>
                                            <label>الإجمالى: </label>
                                            <span class="rounded"><%= CurrentRequest.CurrentPrice.Value.ToCurrency("ريال") %></span>
                                        </td>
                                        <td>
                                            <label>تكلفة الشحن:</label>
                                            <span class="ga"><%= ShippingPrice.ToCurrency("ريال") %></span>
                                        </td>
                                        <td>
                                            <label>قيمة الخدمة:</label>
                                            <span class="ga"><%= ServicePrice.ToCurrency("ريال") %></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 form-group clearfix">
                                <asp:LinkButton Text="إرسال" runat="server" CssClass="nxt s-cl clasic-btn" ID="btnSave" />
                                <%--<a href="card-info.aspx" class="nxt s-cl clasic-btn">Pay Now</a>--%>
                                <%-- <a data-toggle="collapse" data-parent="#accordion500" href="card-info.aspx" class="app-close s-cl clasic-btn">Pay Later</a>--%>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" class="prv s-cl clasic-btn">السابق</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading">Request Details<i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse504" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-12 form-group clearfix">
                                <a href="#" class="nxt s-cl clasic-btn">Proceed</a>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="prv s-cl clasic-btn">Previous</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script>
        $(document).ready(function () {
            $(".myTab a").click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });
    </script>
</asp:Content>
