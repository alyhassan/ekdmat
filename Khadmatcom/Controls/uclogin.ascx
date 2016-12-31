<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="uclogin.ascx.cs" Inherits="Khadmatcom.Controls.uclogin" %>

<div class="modal fade validationEngineContainer" id="p7" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header modal-header-success">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h1><i class="fa my-lock">&nbsp;</i>تسجيل الدخول</h1>
            </div>
            <div class="modal-body">

                <div class="clearfix login-body">
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <div class="clearfix error text-center">Username or Password are incorrect</div>
                        <label class="form-label">البريد الإلكتروني</label>
                        <input type="text" id="username" class="form-control validate[required,custom[email]]" required="required" placeholder="أدخل اسم المستخدم" runat="server"  />
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label class="form-label">كلمة المرور</label>
                        <input type="password" id="password" class="form-control validate[required]" required="required" placeholder="أدخل كلمة المرور" runat="server" />
                    </div>

                    <div class="col-md-10 col-md-offset-1 form-group">
                        <label class="checkbox">
                            <input type="checkbox" name="remember" runat="server" ID="chkRemember"/>
                            <span>تذكرني</span>

                        </label>
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <asp:Button Text="دخول" runat="server" ID="btnLogin" OnClick="btnLogin_OnClick" OnClientClick="return validateForm('#p7', 'ar');" CssClass="btn my-btn btn-block" />
                        <%--<button type="submit" class="btn my-btn btn-block">دخول</button>--%>
                    </div>
                    <div class="col-md-10 col-md-offset-1 form-group">
                        <span class="pull-left"><a href="<%= GetLocalizedUrl("register") %>" id="register">التسجيل</a></span>
                        <span class="pull-right"><a href="<%= GetLocalizedUrl("forget-password") %>">نسيت كلمة السر?</a></span>
                    </div>

                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">إلغاء</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
