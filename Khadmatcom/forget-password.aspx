<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="forget-password.aspx.cs" Inherits="Khadmatcom.forget_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa my-lock">&nbsp;</i>نسيت كلمة المرور</h1>
        </div>
        <div class="modal-body">
            <div class="clearfix login-body validationEngineContainer" id="registerForm">
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">البريد الإلكترونى</label>
                    <input type="email" class="form-control  validate[required,custom[email]]" required="required" placeholder="" runat="server" id="txtEmail" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <asp:Button Text="ارسل" runat="server" ID="btnRegister" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#registerForm', 'ar');" OnClick="btnRegister_OnClick" />

                </div>
            </div>
            <%--<div class="clearfix login-body validationEngineContainer" id="registerForm2">
                <div class="col-md-10 col-md-offset-1 form-group">
                    
                    <label class="form-label">رقم الهاتف</label>
                    <input type="email" class="form-control  validate[required]" required="required" placeholder="" runat="server" id="txtPhone" />
                </div>
                 <div class="col-md-10 col-md-offset-1 form-group">
                    
                    <label class="form-label">الرسالة</label>
                    <textarea id="txtMessage" class="form-control  validate[required]" rows="3" runat="server"></textarea>
                     </div>
                <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <asp:Button Text="ارسل" runat="server" ID="Button1" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#registerForm2', 'ar');" OnClick="btnSend_OnClick" />
                 
                </div>
                </div>--%>
        </div>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
</asp:Content>
