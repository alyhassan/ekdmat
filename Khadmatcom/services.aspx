<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="services.aspx.cs" Inherits="Khadmatcom.services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="javascript:{}"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub  alif"><a class="anchor" href="<%= GetLocalizedUrl(sectionName+"/categories") %>"><%= GetGlobalResourceObject("general.aspx",sectionName) %></a></li>
        <li class="sub alif"><a class="anchor" href="<%= GetLocalizedUrl(string.Format("{0}/{1}/{2}/categories",sectionName,categoryUrlName,categoryId)) %>"><%= CategoryName %></a></li>
        <li class="sub active alif"><a href="javascript:{}"><%= SubcategoryName %></a></li>
        <li class="hidden sub-remove "><a href="#p10" data-toggle="modal" id="aja">Application</a></li>
    </ul>

    <div id="main" class="tab-pane fade in active">
        <div id="" class="owl-demo owl-carousel owl-theme">
            <asp:ListView runat="server" ID="lvCategories" SelectMethod="GetServices" ItemPlaceholderID="PlaceHolder1" GroupItemCount="12" ItemType="Khadmatcom.Services.Model.Service">
                <GroupTemplate>
                    <div class="item myTab">
                        <div class="clearfix Pslider P-slider">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                        </div>
                    </div>
                </GroupTemplate>
                <ItemTemplate>
                    <a href="javascript:{}" onclick='requestService(<%# Item.Id %>,"<%# Item.Notes %>",<%# Item.EstamaitedCost %>,"<%# Item.Options.ToLower() %>")' title="<%# Item.Name %>" class="anchor">
                        <!--href="#p10"-->
                        <span class="top-span">خدمة</span>
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
            $(".myTab a").click(function (e) {
                //e.preventDefault();
                // $(this).tab('show'); //temperorey comented 
            });

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

            $('#ddlCount').on('change', function () {
               //$('#servicePrice').html(this.value * parseInt($('#hfServicePrice').val()));
            });

            $('#ddlCount').change(function () {
                $('#servicePrice').html(this.value * parseInt($('#hfServicePrice').val()));
            });
        });

        function requestService(id, notes, price, options) {
            $('#hfServiceId').val(id);
            $('#ddlService').val(id);
            $('#lblNotes').html(notes);
            $('#servicePrice').html(price);
            $('#hfServicePrice').val(price);
            $("#p10").modal({ backdrop: 'static', show: true });

            $('.options').addClass('hidden');
            if (options != '') {
                var x = options.split(",");
                for (var i = 0; i < x.length; i++) {
                    $('.o' + x[i]).removeClass('hidden');
                }
            }
        }


    </script>
</asp:Content>

