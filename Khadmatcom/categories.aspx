<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="categories.aspx.cs" Inherits="Khadmatcom.categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl("") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub active alif"><a href="javascript:{}"><%= GetGlobalResourceObject("general.aspx",sectionName) %></a></li>
    </ul>

    <div id="main" class="tab-pane fade in active">
        <div id="" class="owl-demo owl-carousel owl-theme">
            <asp:ListView runat="server" ID="lvCategories" SelectMethod="GetCategories" ItemPlaceholderID="PlaceHolder1" GroupItemCount="12" ItemType="Khadmatcom.Services.Model.ServiceCategory">

                <GroupTemplate>
                    <div class="item myTab">
                        <div class="clearfix Pslider P-slider">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                        </div>
                    </div>
                </GroupTemplate>
                <ItemTemplate>
                    <a href="<%# GetLocalizedUrl(string.Format("{0}/{1}/{2}/categories",sectionName,Item.UrlName,Item.Id)) %>" title="<%# Item.Name %>" class="">
                        <span class="top-span">خدمات</span>
                        <span class="bot-span"><%# Item.Name %></span>

                    </a>

                </ItemTemplate>
            </asp:ListView>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/carousel-js/owl.carousel.js"></script>
    <script src="/Scripts/carousel-js/owl.carousel.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$(".myTab a").click(function (e) {
            //    e.preventDefault();
            //    $(this).tab('show');
            //});


            $(".owl-demo").owlCarousel({

                navigation: true, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                singleItem: true

                // "singleItem:true" is a shortcut for:
                // items : 1, 
                // itemsDesktop : false,
                // itemsDesktopSmall : false,
                // itemsTablet: false,
                // itemsMobile : false

            });

            $(".owl-prev").addClass("fa");
            $(".owl-prev").addClass("fa-chevron-left");
            $(".owl-prev").text("");

            $(".owl-next").addClass("fa");
            $(".owl-next").addClass("fa-chevron-right");
            $(".owl-next").text("");

        });




    </script>
</asp:Content>
