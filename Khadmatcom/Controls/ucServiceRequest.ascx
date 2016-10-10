<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucServiceRequest.ascx.cs" Inherits="Khadmatcom.Controls.ucServiceRequest" %>

<div class="modal fade" id="p10" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <asp:HiddenField ID="hfServiceId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hfCityId" runat="server" ClientIDMode="Static" />
    <div class="modal-dialog  service-div">
        <div class="modal-content">
            <div class="modal-header modal-header-success">
                <button type="button" class="close app-close" data-dismiss="modal" aria-hidden="true"><span class="fa fa-times" aria-hidden="true"></span></button>
                <h1>طلب خدمة</h1>
            </div>

            <div class="modal-body panel">
                <div class="row">
                    <div class="col-md-12">
                        <ul class="nav nav-tabs nav-arow myTab col-lg-10 col-md-10 col-xs-6 col-sm-9 navbar-right pull-right" id="ai">
                            <li class="active"><a data-toggle="collapse" data-parent="#accordion500" href="#collapse500">بيانات رئيسية</a></li>
                            <%--<li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse501">المرفقات</a></li>
                     <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse502">بيانات الشحن </a></li>--%>
                            <li><a data-toggle="collapse" data-parent="#accordion500" href="#collapse503">متطلبات الطلب</a></li>
                        </ul>
                         <ul class="nav nav-bar  col-lg-2 col-md-2 col-xs-6 col-sm-3 navbar-left">
                              <li class="text-success text-left">
                                 <div class="price_custom">
                           <table  style="width:auto;margin:auto;">
                               <tr><td colspan="2">سعر الخدمة المبدأى</td></tr>
                                <tr><td>ريال</td><td>0000</td></tr>
                           </table>
                           </div>

                              </li>
                        </ul>
                    </div>
                </div>
                <%--    <a class="accordion-toggle indicator collapsed" data-toggle="collapse" data-parent="#accordion500" href="#collapse500" aria-expanded="false">Characteristic of your services from the rest of institutions that provide the same services? <i class="indi fa fa-chevron-down"></i>
                        </a>--%>
                <div class="accordion clearfix" id="accordion500">
                    <div class="panel">
                        <div class="clearfix fal">
                            <div class="accordion-heading lanti200">طالب الخدمة &nbsp;   <i class="indi fa fa-chevron-up"></i></div>

                        </div>
                        <div id="collapse500" class="collapse in validationEngineContainer" aria-expanded="true">
                            <div class="accordion-body clearfix">
                               <div class="row ">
                                    <div class="col-md-12 col-xs-12 form-group arabic-r">

                                        <div class="form-group  col-md-2 col-sm-6 col-xs-12 pull-right">
                                            <%-- <span id="lblNotes"></span>--%>
                                            <label class="col-md-12 text-right text-nowrap">رقم الطلب</label>
                                            <span class="fixed-no col-md-12 text-right text-nowrap form-control">###</span>
                                        </div>
                                        <div class="form-group  col-md-3  col-sm-6 col-xs-12 pull-right">
                                            <label class="col-md-12  text-right text-nowrap ">الخدمة المطلوبة</label>
                                            <asp:DropDownList CssClass=" col-md-12  form-control    validate[required]" runat="server" ID="ddlService" Enabled="False" SelectMethod="GetServices" ItemType="Khadmatcom.Services.Model.Service" DataValueField="Id" DataTextField="Name">
                                            </asp:DropDownList>
                                            <%--<select class="s1">
                                            <option>Web Design</option>
                                            <option>Web Design</option>
                                        </select>--%>
                                        </div>
                                        <div class="form-group    col-md-2 col-sm-4 col-xs-12  pull-right">
                                            <label class="col-md-12 col-sm-12 col-xs-12 text-right">العدد</label>
                                            <asp:DropDownList runat="server" CssClass="form-control   validate[required]" ID="ddlCount">
                                                <asp:ListItem Value="" Text="اختر العدد" />
                                                <asp:ListItem Text="1" Value="1" />
                                                <asp:ListItem Text="2" Value="2" />
                                                <asp:ListItem Text="3" Value="3" />
                                                <asp:ListItem Text="4" Value="4" />
                                                <asp:ListItem Text="5" Value="5" />
                                            </asp:DropDownList>
                                            <%-- <select class="s2">
                                            <option>1</option>
                                            <option>2</option>
                                        </select>--%>
                                        </div>
                                        <%--<div class="clearfix"></div>--%>
                                        <div class="form-group  col-md-2 col-sm-4 col-xs-12  pull-right">
                                            <label class="col-md-12">مدينة</label>
                                            <select class="form-control validate[required]" id="ddlCities" onchange="$('#hfCityId').val($('#ddlCities').val());">
                                                <option value="">أختر مدينة</option>
                                                <asp:Repeater runat="server" ItemType="Khadmatcom.Services.Model.City" SelectMethod="GetCities" >
                                                    <ItemTemplate>
                                                        <option value="<%# Item.CityId %>"><%# Item.Name %></option>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </select>
                                        </div>
                                        <div class="form-group  col-md-3 col-sm-4 col-xs-12 pull-right">
                                            <label class="clo-md-12">تاريخ الطلب</label>
                                            <span class="fixed-no"><%= string.Format("{0:MMMM d, yyyy}",DateTime.Now) %></span>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-xs-12 form-group arabic-r">
                                    <div class="clearfix fal">
                                        <h3>بيانات خاصة بالخدمة</h3>
                                    </div>
                                    <div class="clearfix"></div>

                                            <div class="form-group col-md-4 col-sm-4 col-xs-12 o1 options pull-right">       
                                                <input type="text" class="form-control" runat="server" id="txtManagerName" placeholder="اسم مدير المحتوى" />
                                            </div>
                                            <div class="form-group o2 options col-md-4 col-sm-4 col-xs-12 col-md-6 col-sm-6 col-xs-12 pull-right">
                                               
                                                <input type="text" class="form-control" runat="server" id="txtManagerIdentityNumber" placeholder="رقم الهوية" />
                                            </div>
                                            <div class="form-group o3 options col-md-4 col-sm-4 col-xs-12 pull-right">
                                               
                                                <input type="text" class="form-control  validate[custom[email]]" runat="server" id="txtManagerEmail" placeholder="ايميل" />
                                            </div>

                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o5 pull-right">
                                               
                                                <input type="text" class="form-control" runat="server" id="txtWorkOfficeNumber" placeholder="رقم ملف مكتب العمل" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o6 pull-right">
                                                
                                                <input type="text" class="form-control" runat="server" id="txt700Number" placeholder="رقم ال 700 للشركة" />
                                            </div>
                                            <div class="form-group o4 options col-md-4 col-sm-4 col-xs-12 pull-right">
                                               
                                                <input type="text" class="form-control" runat="server" id="txtManagerPhone" placeholder="رقم جوال مدير المحتوى" />
                                            </div>

                                     
                                    
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o17 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtCarModel" placeholder="الموديل" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right o14">
                                               
                                                <select runat="server" id="ddlWorkType" class="form-control">
                                                      <option value="">أختر نوع النشاط</option>
                                                    <option value="مقاولات">مقاولات</option>
                                                    <option value="تجارى">تجارى</option>
                                                </select>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o20 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtAddedActivatyName" placeholder="النشاط المراد إضافته" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o21 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtRemovedActivatyName" placeholder="النشاط المراد حذفه" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o15 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtDurationByDays" placeholder="المدة بالايام" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o30 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtLikesCount" placeholder="عدد اللايكات المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o32 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtViewsCount" placeholder="عدد المشاهدات المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o33 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtClickCount" placeholder="عدد النقرات المطلوب" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o18 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtCount" placeholder="العدد" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o31 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtFollowersCount" placeholder="عدد المتابعين المطلوب" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o70 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtProjectType" placeholder="نوع المشروع" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o76 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtJobTo" placeholder="تعديل الى" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o77 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtLicenceNo" placeholder="رقم الرخصة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o75 pull-right">
                                                <label>سبب التعديل</label>
                                                <textarea rows="5" runat="server" id="txtReason" class="form-control validate[required]"></textarea>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right o46">
                                                     <select runat="server" id="ddlPortName" class="form-control validate[required]">
                                                    <option value=""> اختر أسم المنفذ الجمركى</option>
                                                    <option value="مطار الملك عبدالعزيز">مطار الملك عبدالعزيز</option>
                                                    <option value="الميناء الجاف">الميناء الجاف</option>
                                                    <option value="ميناء جدة الأسلامى">ميناء جدة الأسلامى</option>
                                                    <option value="مطار الملك خالد">مطار الملك خالد</option>
                                                    <option value="ميناء الدمام">ميناء الدمام</option>
                                                    <option value="منفذ البطحاء">منفذ البطحاء</option>
                                                    <option value="منفذ الحديثة">منفذ الحديثة</option>
                                                    <option value="ميناء ضباء">ميناء ضباء</option>
                                                </select>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right o60">
                                                <select runat="server" id="ddlWorkCap" class="form-control validate[required]">
                                                    <option value="">اختر حجم الأعمال</option>
                                                    <option value="اقل من 10 مليون">اقل من 10 مليون</option>
                                                    <option value="أكثر من 10 مليون وأقل من 30 مليون">أكثر من 10 مليون وأقل من 30 مليون</option>
                                                </select>

                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right o16">
                                                <select runat="server" id="ddlCountry" class="form-control">
                                                    <option value="">أختر الدولة المراد زياراتها</option>
                                                    <option value="مقاولات">مصر</option>
                                                    <option value="تجارى">الإمارات</option>
                                                </select>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o43 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtNationality" placeholder="الجنسية" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o44 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtJob" placeholder="المهنة المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o42 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtWorkerCount" placeholder="عدد العمالة المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o26 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtAssest" placeholder="رأس المال" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o27 pull-right">
                                                <textarea class="form-control" runat="server" id="txtPartnerInfo" placeholder="اسماء الشركاء ومقدار حصصهم" rows="5"></textarea>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o49 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtEmployeesCount" placeholder="عدد الموظفين بالمنشأة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o50 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtApprovedUserCount" placeholder="لكم مستخدم تريد منح الصلاحية" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right o51">
                                                <select runat="server" id="ddlCompanyType" class="form-control validate[required]">
                                                     <option value="">أختر نوع كيان المؤسسة</option>
                                                    <option value="مؤسسة فردية">مؤسسة فردية</option>
                                                    <option value="شركة محدودة">شركة محدودة</option>
                                                    <option value="شركة مساهمة">شركة مساهمة</option>
                                                    <option value="شركة تضامنية">شركة تضامنية</option>
                                                </select>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o65 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtProductType" placeholder="نوع المنتج" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o57 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtDate" placeholder="تاريخ" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o68 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtPhone2" placeholder="رقم التليفون" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o78">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtStartDate" placeholder="تاريخ الإصدار" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o79 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtFinishDate" placeholder="تاريخ الإنتهاء" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o80 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtTo" placeholder="نقل الى" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o81 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtAge" placeholder="متوسط العمر" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o69 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtSuggested" placeholder="نوع المنتج" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o83 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtTasheraNo" placeholder="رقم التأشيرة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o87 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtCompanyName" placeholder="اسم المنشأة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o54 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtContainer" placeholder="نوع الكونتينر" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o55 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtShippingCity" placeholder="مدينة الشحن" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o88">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtCarType" placeholder="نوع السيارة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o89 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtCarName" placeholder="اسم السيارة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o92 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtMessageCount" placeholder="عدد الرسائل" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o90 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtProductAddressses" placeholder="رابط السلعة المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o91 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtProductPrice" placeholder="سعر السلعة المطلوبة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o84 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtMofodName" placeholder="اسم المكتب المفوض" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o74 pull-right">
                                                <input type="number" class="form-control validate[required]" runat="server" id="txtReportTo" placeholder="الجهة الموجه لها دراسة الجدوي" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o28 pull-right">
                                                <input type="number" class="form-control validate[required]" runat="server" id="txtTravleInusranceAmount" placeholder="مدة تأمين السفر" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o29 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtTravlerCount" placeholder="عدد الأفراد" />
                                            </div>


                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o34 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtAddressInfo" placeholder="الحى" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o35 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtDistrictInfo" placeholder="عنوان الشارع" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o36 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtBuildingNumber" placeholder="رقم المبني" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o37 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtVisitDate" placeholder="تاريخ الزيارة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o38 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtVisitTime" placeholder="وقت الزيارة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o85 pull-right">
                                                <input type="text" class="form-control validate[required]" runat="server" id="txtApartmentCount" placeholder="عدد الشقق" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtLanguage" placeholder="اللغة" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o94 pull-right">
                                                <select runat="server" id="ddlBuildingType" class="form-control">
                                                    <option value="">أختر نوع السكن</option>
                                                    <option value="شقة">شقة</option>
                                                    <option value="دور">دور</option>
                                                    <option value="استراحة">استراحة</option>
                                                    <option value="فيلا">فيلا</option>
                                                    <option value="قصر">قصر</option>
                                                </select>
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtPageCount" placeholder="عدد الصفحات" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o95 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtIstkdam" placeholder="الإستقدام" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o96 pull-right">

                                                <input type="text" class="form-control" runat="server" id="txtDurationByMonths" placeholder="المدة بالاشهر" />
                                            </div>
                                        


                                   
                                 
                                            <div class="form-group options  col-md-6 pull-right o13">
                                                <label for="chkMedcert">هل لديك شهادة ثانوية</label>
                                                <input type="checkbox" id="chkMedcert" runat="server" />
                                            </div>
                                            <div class="form-group options col-md-6 pull-right o12">
                                                <label for="chkunicert">هل لديك شهادة جامعية</label>
                                                <input type="checkbox" id="chkunicert" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o22">
                                                <label for="chkComCert">هل لديك سجل تجارى</label>
                                                <input type="checkbox" id="chkComCert" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o19">
                                                <label for="chk3Mlion">هل تتجاوز العقود الموقعه3 مليون</label>
                                                <input type="checkbox" id="chk3Mlion" runat="server" />

                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o11">
                                                <label for="chkFamilyCar">هل لديك سيارة عائلية</label>
                                                <input type="checkbox" id="chkFamilyCar" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o63">
                                                <label for="chkAccount">هل لديك نظام محاسبى</label>
                                                <input type="checkbox" id="chkAccount" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o61">
                                                <label for="chkInvoice">هل تحتفظ بنسخة من الفواتير</label>
                                                <input type="checkbox" id="chkInvoice" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o85">
                                                <label for="chkReport">هل لديك ترخيص مساحي من البلدية</label>
                                                <input type="checkbox" id="chkReport" runat="server" class="validate[required]" />

                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o47">
                                                <label for="chkPrePlaning">هل لديك مخطط إبتدائى</label>
                                                <input type="checkbox" id="chkPrePlaning" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o48">
                                                <label for="chkFinalPlaning">هل لديك مخطط نهائى</label>
                                                <input type="checkbox" id="chkFinalPlaning" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o45">
                                                <label for="chkKafeal">يتعهد صاحب المنشأة على ان يتكفل بالسكن والمواصلات</label>
                                                <input type="checkbox" id="chkKafeal" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o7">
                                                <label for="chkMore50">هل المساحة أكثر من 50 متر</label>
                                                <input type="checkbox" id="chkMore50" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o52">
                                                <label for="chkApproveBalance">هل يوجد لديكم ميزانية مصدقة من مكتب المحاسبة</label>
                                                <input type="checkbox" id="chkApproveBalance" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o40">
                                                <label for="chkTourisame">هل تم التسجيل فى بموقع هيئة السياحة</label>
                                                <input type="checkbox" id="chkTourisame" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o71">
                                                <label for="chkTourisameTravel">هل لديكم ترخيص من هيئة السياحة والسفر</label>
                                                <input type="checkbox" id="chkTourisameTravel" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o72">
                                                <label for="chkTourisame">هل لديكم مكتب حالى يمارس النشاط</label>
                                                <input type="checkbox" id="chkOffice" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o56">
                                                <label for="chkProductType">هل تحتوي البضاعة المستوردة علي أجهزة كهربائية </label>
                                                <input type="checkbox" id="chkProductType" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o23">
                                                <label for="chkKeepCommerceRecord">هل ترغب بالإحتفاظ برقم وتاريخ السجل التجارى واسمه</label>
                                                <input type="checkbox" id="chkKeepCommerceRecord" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o24">
                                                <label for="chkRecordAttached">هل السجل مربوط بمكتب العمل وساري</label>
                                                <input type="checkbox" id="chkRecordAttached" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o66">
                                                <label for="chk7Years">هل يتجاوز عمر الشركة 7 سنوات</label>
                                                <input type="checkbox" id="chk7Years" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o67">
                                                <label for="chk3Years">هل يتجاوز عمر الشركة 3 سنوات</label>
                                                <input type="checkbox" id="chk3Years" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o25">
                                                <label for="chkRecordModifed">هل تم التعديل فى السجل التجارى</label>
                                                <input type="checkbox" id="chkRecordModifed" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o82">
                                                <label for="chkRecordModifed">هل تم إستخراج تأشيرة من مكتب العمل</label>
                                                <input type="checkbox" id="chkTashera" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o82">
                                                <label for="chkRecordModifed">هل سبق لكم إستخراج تأشيرة</label>
                                                <input type="checkbox" id="chkTasheraB4" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o73">
                                                <label for="chkRecordModifed">هل لديكم دراسة جدوى</label>
                                                <input type="checkbox" id="chkGadwa" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options col-md-6 col-sm-6 col-xs-12 o59">
                                                <label for="chkMore36">هل عرض الشارع 36 او أكثر</label>
                                                <input type="checkbox" id="chkMore36" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o8">
                                                <label for="chkGarag">هل يتوفر حوش إيواء </label>
                                                <input type="checkbox" id="chkGarag" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o41">
                                                <label for="chkMlion">هل يتوفر لديكم ضمان بنكي بقيمة مليون ريال</label>
                                                <input type="checkbox" id="chkMlion" runat="server" class="validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o39">
                                                <label for="chkBaldayaCert">هل لديكم رخصة بلدية</label>
                                                <input type="checkbox" id="chkBaldayaCert" runat="server" class=" validate[required]" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o53">
                                                <label for="chkSaudi">هل لديكم شريك سعودي</label>
                                                <input type="checkbox" id="chkSaudi" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o62">
                                                <label for="chkReview">هل يتوفر لديكم ميزان مراجعه</label>
                                                <input type="checkbox" id="chkReview" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o64">
                                                <label for="chkAccountRecord">هل لديكم قيود محاسبية</label>
                                                <input type="checkbox" id="chkAccountRecord" runat="server" />
                                            </div>
                                            <div class="form-group options  col-md-6 pull-right o9">
                                                <label for="chkMore50Car">هل لديك أكثر من 50 سيارة</label>
                                                <input type="checkbox" id="chkMore50Car" class=" validate[required]" runat="server" />
                                            </div>

                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o18 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtCarCount" placeholder="عدد السيارات المتوفرة" />
                                            </div>
                                            <div class="form-group options  col-md-4 pull-right o10">
                                                <label for="chkBus">هل لديك باصات</label>
                                                <input type="checkbox" id="chkBus" class=" validate[required]" runat="server" />
                                            </div>
                                            <div class="form-group options col-md-4 col-sm-4 col-xs-12 o93 pull-right">
                                                <input type="text" class="form-control" runat="server" id="txtBusCount" placeholder="عدد الباصات المتوفرة" />
                                            </div>
                                        
                                          <!--<div class="col-md-6 col-xs-12 form-group arabic-r">-->
                                        <div class=" form-group col-md-12 col-md-12 col-xs-12 form-group pull-right">
                                            <textarea rows="5" class="form-control" runat="server" id="txtDetails" placeholder="تفاصيل"></textarea>
                                        </div>
                                        <!--</div>--> 
                                       </div>
                             
                                <div class="col-md-12 col-sm-12 ag-1">
                                    <a href="#" class="righttag">Please register for the follow - up steps</a>
                                    <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" id="test" onclick="NextStep();" class="clasic-btn">follow up</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--    <div class="panel hidden">
                        <div class="clearfix fal">
                            <div class="accordion-heading">المرفقات <i class="indi fa fa-chevron-up"></i></div>
                        </div>
                        <div id="collapse501" class="collapse" aria-expanded="false">
                            <div class="accordion-body clearfix">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>المرفق 1</label>
                                        <asp:FileUpload ID="fup1" runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>المرفق 2</label>
                                        <asp:FileUpload ID="fup2" runat="server" CssClass="form-control" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>المرفق 3</label>
                                        <asp:FileUpload ID="fup3" runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label>المرفق 4</label>
                                        <asp:FileUpload ID="fup4" runat="server" CssClass="form-control" />
                                        <input type="file" class="form-control" />
                                    </div>

                                </div>
                                <div class="clearfix">&nbsp;</div>
                                <div class="col-md-12 form-group">
                                    <a data-toggle="collapse" data-parent="#accordion500" href="#collapse503" class="nxt clasic-btn">follow up</a><span>&nbsp; &nbsp; &nbsp;</span>
                                    <a data-toggle="collapse" data-parent="#accordion500" href="#collapse500" class="prv s-cl clasic-btn">Previous</a>
                                </div>

                            </div>
                        </div>

                    </div>

                    <div class="panel hidden">
                        <div class="clearfix fal">
                            <div class="accordion-heading">Shipping details<i class="indi fa fa-chevron-up"></i></div>
                        </div>
                        <div id="collapse502" class="collapse" aria-expanded="false">
                            <div class="accordion-body clearfix">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>الإسم</label>
                                        <input type="text" class="form-control" runat="server" id="txtFullName" />
                                    </div>
                                    <div class="form-group">
                                        <label>the city</label>
                                        <select class="form-control">
                                            <option>Choose</option>
                                            <option>2</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>العنوان</label>
                                        <input type="text" class="form-control" runat="server" id="txtAddress" />
                                    </div>

                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Country</label>
                                        <select class="form-control">
                                            <option>Choose</option>
                                            <option>2</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Region</label>
                                        <select class="form-control">
                                            <option>Choose</option>
                                            <option>2</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>رقم الجوال / الهاتف</label>
                                        <input type="text" class="form-control" runat="server" id="txtPhone" />
                                    </div>

                                </div>
                                <div class="clearfix">&nbsp;</div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="checkbox form-label">
                                            <input type="checkbox" name="remember" value="1" class="validate[required]" />
                                            <span style="padding-left: 20px;">وافق على شروط إستخدام الموقع</span>

                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-12 form-group clearfix">
                                    <a data-toggle="collapse" data-parent="#accordion50" href="#collapse503" class="nxt clasic-btn">follow up</a>
                                    <a href="card-info.aspx" class="nxt s-cl clasic-btn">Pay Now</a>
                                    <a data-toggle="collapse" data-parent="#accordion500" href="card-info.aspx" class="app-close s-cl clasic-btn">Pay Later</a>
                                    <a data-toggle="collapse" data-parent="#accordion500" href="#collapse501" class="prv s-cl  clasic-btn">Previous</a>
                                </div>

                            </div>
                        </div>

                    </div>--%>


                    <div class="panel">
                        <div class="clearfix fal">
                            <div class="accordion-heading">متطلبات الطلب<i class="indi fa fa-chevron-up"></i></div>
                        </div>

                        <div id="collapse503" class="collapse" aria-expanded="false">
                            <div class="accordion-body clearfix">
                                 <div class="row ">
                                   <%-- <div class="form-group  col-md-2 col-sm-6 col-xs-12 pull-right">--%>
                                     <div class="form-group  col-md-6 col-sm-6 col-xs-12 pull-right">   <span id="lblNotes"></span>
                                    </div>
                                </div>
                                <div class="col-md-12 hidden">
                                    <p>
                                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
                                    </p>
                                </div>

                                <div class="col-md-12 form-group clearfix">

                                    <%-- <a href="#" class="nxt s-cl clasic-btn">Proceed</a>--%>
                                    <asp:LinkButton Text="أتم الطلب" runat="server" ID="btnProceed" CssClass="nxt s-cl clasic-btn" OnClientClick="return true;" OnClick="btnProceed_OnClick" />
                                    <%--  <a data-toggle="collapse" data-parent="#accordion500" href="card-info.aspx" class="app-close s-cl clasic-btn">Pay Later</a>--%>

                                    <a data-toggle="collapse" data-parent="#accordion500" href="#collapse500" class="prv s-cl clasic-btn">Previous</a>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<script>
    function NextStep() {
        var  result = validateForm('#collapse500', '<%= System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName.ToLower() %>');
        if (result) {
            result = <%= Membership.GetUser()!=null%>;
            if (result==true) {
                if ($("#ai li:last").hasClass('active')) {
                    $('.nxt').attr('disabled', true);

                } else {
                    $("#ai").find('.active').removeClass('active').next().addClass('active');
                    //$("#all").find('.active').removeClass('active').next().addClass('active');

                    //$('.active').removeClass('active').next().addClass('active');
                    //$('.active').removeClass('active').next().addClass('active');


                }
            }
            return result;
        }
        return result;
    }
    //$('#ddlCities').change(function () {
    //    $('#hfCityId').val($('#ddlCities').val());
    //});
</script>
