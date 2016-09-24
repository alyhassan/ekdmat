<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="info-page.aspx.cs" Inherits="Khadmatcom.info_page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
                    <div class="modal-header modal-header-success">
                
                        <h1><i class="fa">&nbsp;</i><%= CurrentPage.Title %></h1>
                    </div>
                    <div class="modal-body">
                        <p class="head">
                        <%= CurrentPage.SubTitle %>  
                        </p>
                        <div class="body">
                           <%= CurrentPage.Body %> 
                        </div>

                    </div>

                </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
</asp:Content>
