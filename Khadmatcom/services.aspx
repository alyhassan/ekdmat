<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="services.aspx.cs" Inherits="Khadmatcom.services" %>

<%@ Register Src="~/Controls/ucServiceRequest.ascx" TagPrefix="uc1" TagName="ucServiceRequest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <ul class="nav nav-tabs nav-arow myTab">
        <li class="main alif"><a href="<%= GetLocalizedUrl(sectionName+"/categories") %>"><%= GetGlobalResourceObject("general.aspx","Home") %></a></li>
        <li class="sub  alif"><a class="anchor" href="<%= GetLocalizedUrl(sectionName+"/categories") %>"><%= GetGlobalResourceObject("general.aspx",sectionName) %></a></li>
        <li class="sub alif"><a class="anchor" href="<%= GetLocalizedUrl(string.Format("{0}/{1}/{2}/categories",sectionName,categoryUrlName,categoryId)) %>"><%= CategoryName %></a></li>
        <li class="sub active alif"><a href="javascript:{}"><%= SubcategoryName %></a></li>
        <li class="hidden sub-remove "><a href="#p10" data-toggle="modal" id="aja">Application</a></li>
    </ul>

    <div id="main" class="tab-pane fade in active">
        <asp:HiddenField ID="hfServiceTypeName" runat="server" />
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
                    <a href="javascript:{}" onclick='requestService(<%# Item.Id %>,"<%# Item.Notes %>",<%# Item.EstamaitedCost %>,"<%# Item.Options.ToLower() %>","<%# Item.AvilableCities.ToLower() %>")' title="<%# Item.Name %>" class="anchor">
                        <!--href="#p10"-->
                        <span class="top-span"><%# GetGlobalResourceObject("general.aspx", Item.IdentityType) %></span>
                        <span class="bot-span"><%# Item.Name %></span>

                    </a>

                </ItemTemplate>
                <EmptyDataTemplate>
                    <h3><span class="top-span">لا يوجد خدمات متاحة الان هنا</span></h3>
                </EmptyDataTemplate>
            </asp:ListView>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" runat="server">
    <uc1:ucServiceRequest runat="server" ID="ucServiceRequest" />
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
                if ($('#hfServicePrice').val() == "0")
                    $('#servicePrice').html('غير محدد');
                else
                $('#servicePrice').html(this.value * parseInt($('#hfServicePrice').val()));
                
                
            });

            //calcluate service price option
        });

        function requestService(id, notes, price, options, cities) {
            $('input:text').add('textarea').add('select').val('');
            $('#hfServiceId').val(id);
            $('#ddlService').val(id);
            $('#lblNotes').html(notes);
            if (price > 0)
                $('#servicePrice').html(price);
            else $('#servicePrice').html('غير محدد');
            $('#hfServicePrice').val(price);
            $("#p10").modal({ backdrop: 'static', show: true });

            $('.options').addClass('hidden');
            if (options != '') {
                var x = options.split(",");
                for (var i = 0; i < x.length; i++) {
                    $('.o' + x[i]).removeClass('hidden');
                }
            }

            $('#ddlCities option').attr('disabled', 'disabled');
            $('#ddlCities option[value=""]').removeAttr('disabled');
            if (cities != '') {
                var x = cities.split(",");
                for (var i = 0; i < x.length; i++) {
                    $('#ddlCities option[value="' + x[i] + '"]').removeAttr('disabled'); //.removeClass('hidden');
                }
            }
        }


    </script>
</asp:Content>

