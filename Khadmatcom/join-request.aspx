<%@ Page Title="أنضم لنا" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="join-request.aspx.cs" Inherits="Khadmatcom.join_request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content  joinReq">
        <div class="modal-header modal-header-success">
            <h1><i class="fa my-lock">&nbsp;</i>طلب إشتراك كشريك خدمة</h1>
        </div>
        <div class="modal-body validationEngineContainer" id="joinForm">
            <div class="clearfix login-body">
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">اسم المؤسسة / الشركة</label>
                    <input type="text" class="form-control validate[required]" id="txtCompanyName" placeholder="اسم المؤسسة / الشركة" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">البريد الإلكتروني الرسمي</label>
                    <input type="email" class="form-control validate[required,custom[email]]" id="txtManagerEmail" placeholder="email@e-kdmat.com" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">اسم المدير</label>
                    <input type="text" class="form-control validate[required]" id="txtManagerName" placeholder="اسم المدير" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">رقم الجوال</label>
                    <input type="text" class="form-control col-md-10 validate[required]" onkeypress="return isNumber(event)" id="txtPhoneNumber" placeholder="5234567" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">المدينة</label>
                    <select class="form-control validate[required]" id="ddlCities">
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
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">النشاط</label>
                    <asp:DropDownList runat="server" CssClass="form-control validate[required]" EnableViewState="True" ID="ddlCategories" SelectMethod="GetCategories" AppendDataBoundItems="True" DataTextField="Name" DataValueField="Id">
                        <asp:ListItem Text="اختر نشاط" Value="" />
                    </asp:DropDownList>
                </div>
                
                    <table class="notShow" id="subcategies" >
                        
                   
                    <asp:ListView runat="server" GroupItemCount="3" ItemType="Khadmatcom.Services.Model.ServiceSubcategory" SelectMethod="GetSubcategories">
                        <GroupTemplate>
                            <tr>
                                <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                            </tr>
                        </GroupTemplate>
                        <ItemTemplate>
                            <td>
                                <label class='checkbox c<%# Item.ServiceCategory.Id %>'>
                                    <input type="checkbox" value="<%# Item.Id %>" name="sub_<%# Item.Id %>" id='sub_<%# Item.Id %>' class="good validate[groupRequired[subcatigories]]" />
                                    <span style=""><%# Item.Name %></span>

                                </label>

                            </td>
                        </ItemTemplate>
                    </asp:ListView>
                </table>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <asp:Repeater runat="server" ItemType="Khadmatcom.Services.Model.ServiceSubcategory" SelectMethod="GetSubcategories">
                        <ItemTemplate>

                            <div class='<%# Item.Services.Any()?"":"hidden" %>col-md-10 col-md-offset-1 form-group chu-div notShow services clearfix' id='ki<%# Item.Id %>'>
                                <label class="form-label"><%# Item.Name %></label><br />
                                <asp:Repeater runat="server" ItemType="Khadmatcom.Services.Model.Service" DataSource='<%# Item.Services %>'>
                                    <ItemTemplate>
                                        <div class="col-md-11 col-md-offset-1 form-group clearfix serviceItem">

                                            <div class="notShow table-bordered  col-md-7 col-sm-7" id="showText">
                                                <label>متطلباتها</label><textarea rows="3" class="validate[required]" id='need_<%# Item.Id %>'></textarea>
                                                <label>سعر الخدمة المبدئي</label><input class="validate[required]" onkeypress="return isNumber(event)" type="text" id='price_<%# Item.Id %>' placeholder="1" />
                                            </div>
                                            <label class="checkbox col-md-5 col-sm-5 htv-right pull-right">
                                                <input type="checkbox" value="<%# Item.Id %>" name="ser_<%# Item.Id %>" id='ser_<%# Item.Id %>' class='bad  validate[groupRequired[subcategory<%# Item.SubcategoryId %>]]' />
                                                <span style=""><%# Item.Name %></span>
                                            </label>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                        </ItemTemplate>

                    </asp:Repeater>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <button type="button" class="btn my-btn btn-block" onclick="join()">ارسل الطلب</button>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script>
        $(function () {

            $('#ddlCategories').change(function () {
                //var idx = this.selectedIndex;
                //$("select#selected").prop('selectedIndex', idx);
                if ($(this).val()) {
                    var idx = 'c' + $(this).val();
                    $('#subcategies label').hide();
                    $('#subcategies label.' + idx).show();
                    $('#subcategies').removeClass('notShow');
                } else {
                    $('#subcategies').addClass('notShow');
                }
                $(".services").addClass('notShow');
                $(".bad").removeAttr('checked');
            });

            $("#subcategies input[type='checkbox']").each(function () {
                var item = $(this);
                var id = item.val();
                item.click(function () {
                    if (item.is(':checked'))
                        $("#ki" + id).removeClass('notShow');
                    else
                        $("#ki" + id).addClass(' notShow');
                });
            });


            $(".fa-close").click(function () {
                $("#gl").text("");
                $(".fa-close").hide();
            });
        });

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        $('.services input:checkbox.bad').click(function () {
            var item = $(this);
            var info = item.parent().prev();
            if (item.is(':checked'))
                info.show('slow');
            else
                info.hide('slow');
        });
        function join() {
            if (validateForm('#joinForm', '<%=languageIso %>')) {
                showLoading();
                var requestServices = [];

                $('.services input:checkbox.bad').each(function () {
                    var item = $(this);
                    var id;
                    if (item.is(':checked')) {
                        id = item.val();
                        requestServices.push({ InitailPrice: $('#price_' + id).val(), ServiceNeeds: $('#need_' + id).val(), ServiceId: id });
                    }

                });
                var servicesJsonData = JSON.stringify(requestServices);
                var userData = {
                    cityId: $('select[id$=ddlCities] :selected').val(),
                    companyName: $('#txtCompanyName').val(),
                    contactName: $('#txtManagerName').val(),
                    providerEmail: $('#txtManagerEmail').val(),
                    mainCategoryId: $('select[id$=ddlCategories] :selected').val(),
                    providerPhoneNumber: $('#txtPhoneNumber').val(),
                    servicesJsonData: servicesJsonData
                };
                $.getJSON("/api/Khadmatcom/JoinRequest", userData, function (res) {
                    if (res === "") {
                        hideLoading();
                        $('#subcategies').addClass('notShow');
                        toastr.success("تم إرسال طلبك بنجاح...وسيقوم احد مندوبينا بالإتصال بك  فى أقرب وقت ممكن.", "شكرا لك");
                        //clearFormData("#joinForm");
                    }
                    else {
                        hideLoading();
                        toastr.error(res, "خطأ"); hideLoading();
                    }
                });
            }
        }
    </script>
</asp:Content>
