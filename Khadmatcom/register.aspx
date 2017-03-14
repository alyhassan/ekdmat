<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Khadmatcom.register" meta:resourcekey="PageResource1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa my-lock">&nbsp;</i>التسجيل</h1>
        </div>
        <div class="modal-body">
            <div class="clearfix login-body validationEngineContainer" id="registerForm">
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">الإسم</label>
                    <input type="text" class="form-control  validate[required]" required="required" placeholder="" runat="server" id="txtName" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">البريد الإلكترونى</label>
                    <input type="email" class="form-control  validate[required,custom[email]]" required="required" placeholder="" runat="server" id="txtEmail" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">كلمة المرور</label>
                    <input type="password" class="form-control validate[required]" required="required" placeholder="Please enter password" runat="server" ID="txtPassword" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">تأكيد كلمة المرور</label>
                    <input type="password" class="form-control validate[required,equals[txtPassword]]" name="confirm" runat="server" ID="txtConfirmPassword" required="required" placeholder="Re-enter password" />
                </div>

                <!--Personal-->
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">رقم الجوال:</label>
                    <input type="text" class="form-control validate[required]" required="required"  placeholder="فضلا ادخل رقم الجوال كالتالي ×××××××××966" runat="server" id="txtMobileNumber" />
                </div>

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">المجموعه</label>
                    <select class="form-control validate[required]" ID="ddlGroup" required="required" runat="server">
                        <option>أختار نوع الإشتراك</option>
                        <option value="-1">كل منهما</option>
                        <option value="1">فردي</option>
                        <option value="2">أعمال</option>
                    </select>
                </div>
                
            

                <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>



                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="checkbox form-label">
                        <input type="checkbox" name="remember" class="validate[required]" />
                        <span style="padding-left: 20px;"><a title="إتفاقية الإستخدام" target="_blank" href="<%= GetLocalizedUrl("info/use-agreement") %>">أوافق على سياسة إستخدام الموقع</a> </span>

                    </label>
                </div>


                <div class="col-md-10 col-md-offset-1 form-group">
                    <asp:Button Text="قم بالتسجيل" runat="server" ID="btnRegister" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#registerForm', 'ar');" OnClick="btnRegister_OnClick" />
                   <%--<button type="submit" class="btn my-btn btn-block hidden">Sign Up</button>--%>
                </div>

                <div class="col-md-10 col-md-offset-1 form-group clearfix">
                    <span class="alreadya"><a href="#p7" data-toggle="modal">لديك حساب لدينا بالفعل?</a></span>

                </div>
            </div>

        </div>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
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

    </script>
</asp:Content>
