<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="provider.aspx.cs" Inherits="Khadmatcom.admin_area.provider" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa my-lock">&nbsp;</i>شريك العمل</h1>

        </div>
        <div class="modal-body">
            <div class="clearfix login-body validationEngineContainer" id="providerForm">
                <div class="col-md-10 col-md-offset-1 form-group">
                    <a class="pull-left" href='<%= GetLocalizedUrl("managment/providers") %>'><i class="fa fa-arrow-left">&nbsp;</i>عودة للقائمة الرئيسية</a>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label dir="rtl" class="form-label">الإسم</label>
                    <input type="text" class="form-control  validate[required]" required="required" placeholder="اسم المسؤول" runat="server" id="txtName" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">اسم الشركة</label>
                    <input type="text" class="form-control validate[required]" runat="server" id="txtCompanyName" required="required" placeholder="أدخل اسم الشركة/ المؤسسة" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">رقم السجل التجاري</label>
                    <input type="number" class="form-control validate[required]" runat="server" id="txtIdentityNumber" required="required" placeholder="أدخل رقم السجل التجاري" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">المحافظة</label>
                    <asp:DropDownList runat="server" CssClass="form-control validate[required]" EnableViewState="True" ID="ddlCities" SelectMethod="GetCities" AppendDataBoundItems="True" DataTextField="Name" DataValueField="CityId">
                        <asp:ListItem Text="اختر نشاط" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">النشاط الرئيسي</label>
                    <asp:DropDownList runat="server" CssClass="form-control validate[required]" EnableViewState="True" ID="ddlCategories" SelectMethod="GetCategories" AppendDataBoundItems="True" DataTextField="Name" DataValueField="Id">
                        <asp:ListItem Text="اختر نشاط" Value="" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label dir="rtl" class="form-label">البريد الإلكترونى</label>
                    <input type="email" class="form-control  validate[required,custom[email]]" required="required" placeholder="أدخل البريد الإلكتروني" runat="server" id="txtEmail" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-groupp<%= _id.HasValue?" hidden":"" %>">
                    <label dir="rtl" class="form-label">كلمة المرور</label>
                    <input type="password" class="form-control validate[required]" required="required" placeholder="أدخل كلمة المرور" runat="server" id="txtPassword" />
                </div>


                <!--Personal-->
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">رقم الجوال:</label>
                    <input type="number" class="form-control validate[required]" required="required" placeholder="أدخل رقم الجوال" runat="server" id="txtMobileNumber" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">البنك المتعامل معه</label>
                    <select class="validate[required] form-control" runat="server" id="ddlBanks">
                        <option value="">اختر البنك</option>
                        <option value="1">الراجحي</option>
                        <option value="2">الأهلي</option>
                        <option value="3">الرياض</option>
                        <option value="4">ساب</option>
                        <option value="5">السعودي الفرنسي</option>
                        <option value="6">السعودي للإستثمار</option>
                        <option value="7">البلاد</option>
                        <option value="8">سامبا </option>
                        <option value="9">الإنماء </option>
                        <option value="10">العربي الوطني </option>
                    </select>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label dir="rtl" class="form-label">رقم الحساب:</label>
                    <input type="number" class="form-control validate[required]" required="required" placeholder="" runat="server" id="txtBankAccountNumber" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>



                <%--  <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="checkbox form-label">
                        <input type="checkbox" name="remember" class="validate[required]" />
                        <span style="padding-left: 20px;"><a title="إتفاقية الإستخدام" href="javascript:{}">أوافق على سياسة إستخدام الموقع</a> </span>

                    </label>
                </div>--%>


                <div class="col-md-10 col-md-offset-1 form-group<%= _id.HasValue?" hidden":"" %>">
                    <asp:Button Text="أضف" runat="server" ID="btnRegister" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#providerForm', 'ar');" OnClick="btnRegister_OnClick" />
                    <%--<button type="submit" class="btn my-btn btn-block hidden">Sign Up</button>--%>
                </div>

                <div class="col-md-10 col-md-offset-1 form-group<%= _id.HasValue?"":" hidden" %>">
                    <asp:Repeater OnItemCommand="OnItemCommand" runat="server" SelectMethod="GetProviderServices" ItemType="Khadmatcom.Data.Model.ServiceProvider">
                        <HeaderTemplate>
                            <h1><a href='javascript:{}' onclick="$('#hfState').val(0);showModel('#addService')"><i class="fa fa-plus-circle">&nbsp;</i></a>الخدمات المشترك بها</h1>

                            <table dir="rtl" class="table table-responsive">
                                <tr dir="rtl">
                                    <th>م</th>
                                    <th>اسم الخدمة
                                    </th>
                                    <th>السعر المبدئي
                                    </th>
                                    <th>وقت التنفيذ المبدئي
                                    </th>
                                    <th>المدينة
                                    </th>
                                    <th>عمولة الموقع
                                    </th>
                                    <th>شريك أساسي</th>
                                    <th></th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr dir="rtl">
                                <td><%# Container.ItemIndex+1 %></td>
                                <td><%# Item.Service.LocalizedServices.First(l=>l.LanguageId==LanguageId).Title %></td>
                                <td><%# Item.EstamaitedCost %></td>
                                <td><%# Item.EstamaitedTime %></td>
                                <td><%# Item.City.Name %></td>
                                <td><%# Item.SiteCommission %>%</td>
                                <td>
                                    <input type="checkbox" <%# Item.IsMain?"checked":"" %> disabled="disabled" /></td>
                                <td>
                                    <a href='javascript:{}' onclick="editService('#addService',<%# Item.Id %>,<%# Item.EstamaitedCost %>,<%# Item.EstamaitedTime %>,<%# Item.SiteCommission %>,<%# Item.ServiceId %>,<%# Item.CityId %>,<%# Item.IsMain.ToString().ToLower() %>)"><i class="fa fa-edit">&nbsp; تعديل</i></a>
                                    <asp:LinkButton Text="حذف" CommandName="Delete" CommandArgument="<%# Item.Id %>" OnClientClick="return confirm('هل انت متاكد من الحذف؟')" runat="server" CssClass="fa fa-remove" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:Button Text="تحديث" runat="server" ID="btnUpdate" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#providerForm', 'ar');" OnClick="btnUpdate_OnClick" />

                </div>
            </div>

        </div>


    </div>

    <div class="modal fade validationEngineContainer" id="addService" role="dialog">
        <div class="modal-dialog" dir="rtl">
            <div class="modal-content">
                <div class="modal-header modal-header-success">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times" aria-hidden="true"></span></button>
                    <h1 class="modal-title">إضافة / تعديل خدمة</h1>
                </div>
                <div class="modal-body">
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label dir="rtl" class="form-label">الخدمة</label>
                        <asp:DropDownList ClientIDMode="Static" runat="server" CssClass="form-control  validate[required]" ID="ddlServices" SelectMethod="GetServices" DataValueField="id" DataTextField="Name" AppendDataBoundItems="True">
                            <asp:ListItem Text="أختار خدمة" Value="" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label dir="rtl" class="form-label">المحافظة</label>
                        <asp:DropDownList ClientIDMode="Static" runat="server" CssClass="form-control  validate[required]" ID="ddlServiceCity" SelectMethod="GetCities" DataValueField="CityId" DataTextField="Name" AppendDataBoundItems="True">
                            <asp:ListItem Text="أختار محافظة" Value="" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <input type="checkbox" class="good " runat="server" id="chkIsMain" />
                        <label dir="rtl" for="chkIsMain">شريك أساسي</label>
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label dir="rtl" class="form-label">التكلفة المبدئية</label>
                        <asp:TextBox runat="server" ID="txtCost" CssClass="form-control  validate[required]" />
                    </div>

                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label dir="rtl" class="form-label">وقت التنفيذ المبدئي</label>
                        <asp:TextBox runat="server" ID="txtTime" CssClass="form-control " />
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label dir="rtl" class="form-label">عمولة الموقع</label>

                        <asp:TextBox runat="server" ID="txtSiteCommission" CssClass="form-control validate[required]" placeholder="4" />

                    </div>




                </div>
                <div class="modal-footer">
                    <div class="col-md-10 col-md-offset-1 form-group pull-left">
                        <asp:Button Text="حفظ" runat="server" ID="btnSave" CssClass="btn btn-default glyphicon-floppy-save" OnClientClick="return validateForm('#addService', 'ar');" OnClick="btnAddService_Click" /><%-- --%>
                    </div>
                </div>
            </div>
            <input type="hidden" id="hfState" value="0" runat="server" clientidmode="Static" />
            <input type="hidden" id="hfId" value="0" runat="server" clientidmode="Static" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="js" runat="server">
    <script>
        $(function () {
            $("#ki input[type='checkbox']").click(function () {
                var mytext = $(this).next('span').text();
                if ($("input[type='checkbox']").is(':checked')) {
                    $("#gl").text(mytext);
                    $(".fa-close").show();
                }
                else if ($("input[type='checkbox']").not(':checked')) {

                    $("#gl").text("");
                    $(".fa-close").hide();
                }
            });

            $(".fa-close").click(function () {
                $("#gl").text("");
                $(".fa-close").hide();
            });
        });
        function showModel(selector) {
            var state = $('#hfState').val();
            if (state == "0") {
                $('#txtCost').val('1');
                $('#txtTime').val('1');
                $('#txtSiteCommission').val('4');
                $('#ddlServices').val('');
                $('#ddlServiceCity').val('');
            }
            $(selector).modal({
                backdrop: 'static',
                keyboared: false
            });

        }

        function editService(selector, id, cost, time, comm, serviceId, cityId, isMain) {
            $('#hfId').val(id);
            $('#hfState').val(1);
            $('#txtCost').val(cost);
            $('#txtTime').val(time);
            $('#txtSiteCommission').val(comm);
            $('#ddlServices').val(serviceId);
            $('#ddlServiceCity').val(cityId);
            if (isMain == 'true')
                $('#chkIsMain').attr('checked', 'checked');
            else $('#chkIsMain').removeAttr('checked');
            showModel(selector);
        }

    </script>
</asp:Content>
