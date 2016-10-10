<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="card-info.aspx.cs" Inherits="Khadmatcom.card_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .modal-body .body {
            min-height: 180px;
        }

        #accordion500 textarea {
            width: 100%;
        }

        .same-div {
            padding-right: 0px;
            padding-left: 0px;
            display: block;
            width: 100%;
        }

        @media (max-width:992px) {
            .same-div {
                float: right;
                padding-right: 20px;
            }
        }

        .b-ac {
            background: url(/images/radio-bg.jpg) no-repeat scroll bottom left;
            background-size: 100% 100%;
            width: 100%;
        }

        .myss label {
            margin-left: 5px;
        }

        .rounded {
            float: left;
            font-size: 1.0em;
            padding: 0px 15px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="modal-content">
        <div class="modal-header modal-header-success">
            <%--        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>--%>
            <h1><i class="fa">&nbsp;</i>Service Request</h1>
        </div>
        <div class="modal-body">
             <div class="row">
                    <div class="col-md-12">
                           <ul class="nav nav-bar   col-lg-2 col-md-2 col-xs-3 col-sm-3 navbar-left">
                            <li class="text-success text-left">سعر الخدمة</li>
                        </ul>
            <ul class="nav nav-tabs nav-arow myTab   col-lg-10 col-md-10 col-xs-9 col-sm-9  pull-right" id="ai">
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse500">Service Req</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse501">Attaching</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse502">Shipping</a></li>
                <li class="active"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse503">Payment m</a></li>
                <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse504">request det</a></li>

            </ul>
            <%--    <a class="accordion-toggle indicator collapsed" data-toggle="collapse" data-parent="#accordion500" href="#collapse500" aria-expanded="false">Characteristic of your services from the rest of institutions that provide the same services? <i class="indi fa fa-chevron-down"></i>
                        </a>--%>
            <div class="accordion clearfix" id="accordion500">
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading ">Service Request &nbsp; Sami Jadallah  <i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse500" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6 col-xs-12 form-group arabic-r">

                                <div class="same-div">
                                    <label>Application No.</label>
                                    <span class="fixed-no">120</span>
                                </div>
                                <div class="same-div">
                                    <label>service type</label>
                                    <select class="s1">
                                        <option>Web Design</option>
                                        <option>Web Design</option>
                                    </select>
                                </div>
                                <div class="same-div">
                                    <label>the number</label>
                                    <select class="s2">
                                        <option>1</option>
                                        <option>2</option>
                                    </select>
                                </div>
                                <div class="clearfix"></div>
                                <div class="same-div">
                                    <label>The date of application.</label>
                                    <span class="fixed-no">November 8, 2016</span>
                                </div>

                            </div>
                            <div class="col-md-6 col-xs-12 form-group arabic-r">
                                <div class="same-div">
                                    <label>Details you want to add</label>
                                    <textarea rows="5"></textarea>
                                </div>
                            </div>
                            <div class="col-md-12 col-sm-12 ag-1">
                                <a href="#" class="righttag">Please register for the follow - up steps</a>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="nxt clasic-btn">follow up</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading">Attaching documents <i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse501" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Attachments 1</label>
                                    <input type="file" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>Attachments 2</label>
                                    <input type="file" class="attach" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Attachments 3</label>
                                    <input type="file" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>Attachments 4</label>
                                    <input type="file" class="attach" />
                                </div>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 form-group">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" class="nxt clasic-btn">follow up</a><span>&nbsp; &nbsp; &nbsp;</span>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse500" class="prv s-cl clasic-btn">Previous</a>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading">Shipping details<i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse502" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Full Name</label>
                                    <input type="text" class="attach" />
                                </div>
                                <div class="form-group">
                                    <label>the city</label>
                                    <select class="attach">
                                        <option>Choose</option>
                                        <option>2</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" class="attach" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Country</label>
                                    <select class="attach">
                                        <option>Choose</option>
                                        <option>2</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Region</label>
                                    <select class="attach">
                                        <option>Choose</option>
                                        <option>2</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Telephone number</label>
                                    <input type="text" class="attach" />
                                </div>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="form-group col-md-12">
                                <label class="checkbox form-label">
                                    <input type="checkbox" name="remember" value="1" />
                                    <span style="padding-left: 20px;">I agree to the terms of use Privacy </span>

                                </label>
                            </div>
                            <div class="col-md-12 form-group">
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="nxt clasic-btn">follow up</a><span>&nbsp; &nbsp; &nbsp;</span>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="prv s-cl clasic-btn">Previous</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading lanti200">Payment method<i class="indi fa fa-chevron-down"></i></div>
                    </div>
                    <div id="collapse503" class="collapse in" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-12">
                                <div class="col-md-6 col-sm-6  col-xs-12">
                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="1" /><span>Credit card</span></label>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6  col-xs-12">

                                    <div class="form-group b-ac">
                                        <label class="clearfix">
                                            <input type="radio" name="cars" value="2" /><span>Bank transfer</span></label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card1">
                                <div class="form-group col-md-12 text-center visa-img">
                                        <img src="/images/visa-bg.jpg" />

                                    </div>
                                    <div class="form-group">
                                         <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                              <label>اسم صاحب البطافة</label>
                                            <input type="text" class="attach form-control" placeholder="" />
                                        </div>
                                        <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                             <label>رقم الهاتف</label>
                                        <input type="text" class="attach form-control" placeholder="" />
                                    </div>
                                          <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                              <label>رقم البطاقة</label>
                                            <input type="text" class="attach form-control" placeholder="" />
                                        </div>
                                          <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                               <label>الرقم السرى</label>
                                            <input type="text" class="attach form-control" placeholder="" />
                                        </div>
                                        <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label> VIS رقم</label>
                                            <input type="text" class="attach form-control" name="VIS" value="" placeholder="" />
                                        </div>
                                          <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                              <label> تاريخ الانتهاء</label>
                                        <input type="text" class="attach form-control" placeholder="" />
                                    </div>
                                    </div>
                            
                              
                            </div>
                            <div class="col-md-12 c-card" style="display: none;" id="c-card2">
                                        <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>أسم صاحب البطاقة</label>
                                            <input type="text" class="attach form-control" />
                                        </div>
                                      <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>رقم الهاتف</label>
                                            <input type="text" class="attach form-control" />
                                        </div>
                                         <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>أسم البنك المحول منه</label>
                                           <select runat="server" id="ddlBankListFrom" class="attach form-control">
                                            <option value="1">بنك 1</option>
                                            <option value="2">بنك 2</option>
                                        </select>
                                        </div>
                                 <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>أسم البنك المحول اليه</label>
                                          <select runat="server" id="ddlBankListTo" class="attach form-control">
                                            <option value="1">بنك 1</option>
                                            <option value="2">بنك 2</option>
                                        </select>
                                        </div>

                                      <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>رقم الحساب</label>
                                            <input type="text" class="attach form-control"  placeholder="اخر 4 ارقام فى الحساب"/>
                                        </div>
                                     <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>قيمة الحوالة</label>
                                            <input type="text" class="attach form-control" />
                                        </div>
                                   
                                <div class="form-group col-md-6 col-sm-6 col-xs-12  pull-right">
                                            <label>رقم الحوالة</label>
                                            <input type="text" class="attach form-control" />
                                        </div>     
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12">
                                <table style="width: 100%;" border="1" cellpadding="20" class="table myss">
                                    <tr>
                                        <td>
                                            <label>Total kidney: </label>
                                            <span class="rounded">250 Rs</span>
                                        </td>
                                        <td>
                                            <label>Shipping:</label>
                                            <span class="ga">10 Rs</span>
                                        </td>
                                        <td>
                                            <label>The total amount:</label>
                                            <span class="ga">250 Rs</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="clearfix">&nbsp;</div>
                            <div class="col-md-12 form-group clearfix">
                                <a href="card-info.aspx" class="nxt s-cl clasic-btn">Pay Now</a>
                                <a data-toggle="collapse" data-parent="#accordion500" href="card-info.aspx" class="app-close s-cl clasic-btn">Pay Later</a>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse502" class="prv s-cl clasic-btn">Previous</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel">
                    <div class="clearfix fal">
                        <div class="accordion-heading">Request Details<i class="indi fa fa-chevron-up"></i></div>
                    </div>
                    <div id="collapse504" class="collapse" aria-expanded="false">
                        <div class="accordion-body clearfix">
                            <div class="col-md-12 form-group clearfix">

                                <div class="alert alert-success" role="alert"> <strong> تم ارسال الطلب</strong> شكرا لاختياركم خدماتكم <span class="glyphicon glyphicon-ok"></span> </div>
                                <a href="#" class="nxt s-cl clasic-btn">Proceed</a>
                                <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="prv s-cl clasic-btn">Previous</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="js" runat="server">
    <script>
        $(document).ready(function () {
            $(".myTab a").click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });
    </script>
</asp:Content>
