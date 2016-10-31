<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="user-info.aspx.cs" Inherits="Khadmatcom.user_info" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <h1><i class="fa my-lock">&nbsp;</i>البيانات الشخصية</h1>
        </div>
        <div class="modal-body">
            <div class="clearfix login-body validationEngineContainer" id="registerForm">
                <div class="col-md-10 col-md-offset-1 form-group">
                   <label class="form-label">الإسم</label>
                    <input type="text" class="form-control  validate[required]" required="required" placeholder="" runat="server" id="txtName" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <div class="clearfix error text-center">Error or Successful message</div>
                    <label class="form-label">البريد الإلكترونى</label>
                    <input type="email" class="form-control  validate[required,custom[email]]" disabled="True" required="required" placeholder="" runat="server" id="txtEmail" />
                </div>

                <!--Personal-->
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">رقم الجوال:</label>
                    <input type="text" class="form-control validate[required]" required="required"  placeholder="" runat="server" id="txtMobileNumber" />
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
                    <asp:Button Text="حفظ" runat="server" ID="btnRegister" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#registerForm', 'ar');" OnClick="btnRegister_OnClick" />
                   
                </div>

                
            </div>

        </div>


    </div>
    <br/>
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <h1><i class="fa my-lock">&nbsp;</i>تحديث كلمة المرور</h1>
        </div>
        <div class="modal-body">
            <div class="clearfix login-body validationEngineContainer" id="passwordForm">
                <div class="col-md-10 col-md-offset-1 form-group">
                   <label class="form-label">كلمة المرور القديمة</label>
                    <input type="text" class="form-control  validate[required]" required="required" placeholder="Please old enter password" runat="server" id="txtOldPassword" />
                </div>
                

                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">كلمة المرور الجديدة</label>
                    <input type="password" class="form-control validate[required]" required="required" placeholder="Please enter password" runat="server" ID="txtPassword" />
                </div>
                <div class="col-md-10 col-md-offset-1 form-group">
                    <label class="form-label">تأكيد كلمة المرور الجديدة</label>
                    <input type="password" class="form-control validate[required,equals[txtPassword]]" name="confirm" runat="server" ID="txtConfirmPassword" required="required" placeholder="Re-enter password" />
                </div>

               <div class="col-md-10 col-md-offset-1 form-group display-lab">
                    <label id="gl" class="fa fa-close"></label>
                </div>





                <div class="col-md-10 col-md-offset-1 form-group">
                    <asp:Button Text="تحديث" runat="server" ID="Button1" CssClass="btn my-btn btn-block" OnClientClick="return validateForm('#passwordForm', 'ar');" OnClick="btnUpdatePassword_OnClick" />
                   
                </div>

            </div>

        </div>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="js" runat="server">
</asp:Content>
