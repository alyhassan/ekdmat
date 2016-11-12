<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="providers.aspx.cs" Inherits="Khadmatcom.admin_area.providers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa my-lock">&nbsp;</i>شركاء العمل</h1>
        </div>
        <div class="modal-body">

            <div class="row">
                <asp:Repeater runat="server" SelectMethod="GetProvidersList" ItemType="Khadmatcom.Data.Model.User">
                    <HeaderTemplate>
                        <h1><a href='<%= GetLocalizedUrl("managment/providers/new") %>'><i class="fa fa-plus-circle">&nbsp;</i></a>الخدمات المشترك بها</h1>

                        <table dir="rtl" class="table table-responsive">
                            <tr dir="rtl">
                                <th>م</th>
                                <%--<th>اسم المسؤول
                                </th>--%>
                                <th>اسم الشركة - المؤسسة
                                </th>
                                <th>المحافظة
                                </th>

                                <th>النشاط الرئيسي
                                </th>
                                <th>البريد الإلكتروني
                                </th>
                                <th>رقم الهاتف - الجوال
                                </th>
                                <th></th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr dir="rtl">
                            <td><%# Container.ItemIndex+1 %></td>
                            <%--<td><%# Item.FullName %></td>--%>
                            <td><a href='<%# GetLocalizedUrl(string.Format("managment/providers/{0}/provider-info",Item.Id)) %>'><%# Item.CompanyName %></a></td>
                            <td><%# Item.City.LocalizedCities.First(l=>l.LanguageId==LanguageId).Title %></td>
                            <td><%# Item.ServiceCategory.LocalizedServiceCategories.First(l=>l.LanguageId==LanguageId).Title %></td>
                            <td><a href="mailto:<%# Item.Email %>?Subject=Administration Contact"><%# Item.Email %></a></td>
                            <td><%# Item.MobielNumber %></td>
                            <td>
                                <a href='<%# GetLocalizedUrl(string.Format("managment/providers/{0}/provider-info",Item.Id)) %>'><i class="fa fa-edit">&nbsp; تعديل</i></a>

                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="js" runat="server">
</asp:Content>
