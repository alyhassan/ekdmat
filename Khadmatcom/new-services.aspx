<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="new-services.aspx.cs" Inherits="Khadmatcom.clients.new_services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.theme.css" />
    <link rel="stylesheet" type="text/css" href="/Content/carousel-css/owl.carousel.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div id="chuu-owl" class="chuu owl-carousel owl-theme">
         <asp:ListView runat="server" ID="lvServiceRequest" SelectMethod="GetServiceRequests" ItemPlaceholderID="PlaceHolder1" GroupItemCount="3" ItemType="Khadmatcom.Data.Model.ServiceRequest">
                <GroupTemplate>
                   <div class="item">
            <div class="accordion clearfix" id="accordion01">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                        </div>
                    </div>
                </GroupTemplate>
                <ItemTemplate>
                    <div class="panel">
                    <div class="accordion-heading">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion4" href='#right<%# Item.Id %>' aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red"><%# Item.Id %></span> </span>
                                    <span>Service: <span class="blue"><%# Item.Service.Name %></span> </span>
                                    <span>the type of service:<span class="blue"><%# Item.Service.ServiceSubcategory.Name %></span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        <%# Servston.Utilities.Truncate(Item.Details,250) %>
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right<%# Item.Id %>" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                 <%# Item.Details %>
                            </p>
                            <div class="L-button" id="">
                                <a href="javascript:{}" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>

                </ItemTemplate>
            </asp:ListView>
      <%--  <div class="item">
            <div class="accordion clearfix" id="accordion4">
                <div class="panel">
                    <div class="accordion-heading">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion4" href="#right01" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right01" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button" id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion4" href="#right02" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right02" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion4" href="#right03" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right03" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="item">
            <div class="accordion clearfix" id="accordion01">
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion01" href="#right5" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right5" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion01" href="#right6" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right6" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion01" href="#right7" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right7" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="item">
            <div class="accordion clearfix" id="accordion02">
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion02" href="#right9" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right9" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion02" href="#right10" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right10" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="accordion-heading ">
                        <a class="clearfix accordion-toggle collapsed indicator" data-toggle="collapse" data-parent="#accordion02" href="#right11" aria-expanded="false">

                            <div class="L-container">
                                <div class="L1">
                                    <span class="ni">Order number: <span class="red">123</span> </span>
                                    <span>Service: <span class="blue">design</span> </span>
                                    <span>the type of service:<span class="blue">design Web site</span> </span>
                                </div>
                                <div class="L2">
                                    services details:
                                </div>
                                <div class="L3">
                                    <p>
                                        Service details here ... Here are the details of service ... service ... service here Details Details here ...
                                        
                                    </p>
                                </div>
                            </div>

                        </a>

                    </div>
                    <div id="right11" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix ">
                            <p>
                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specime
                            </p>
                            <div class="L-button " id="">
                                <a href="Default.aspx?se=hi" class="editt">Edit</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>--%>


    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script src="/Scripts/carousel-js/owl.carousel.js"></script>
    <script src="/Scripts/carousel-js/owl.carousel.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#chuu-owl").owlCarousel({

                navigation: true, // Show next and prev buttons
                slideSpeed: 300,
                paginationSpeed: 400,
                singleItem: true
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
